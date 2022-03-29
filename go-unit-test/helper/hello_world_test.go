package helper

import (
	"fmt"
	"runtime"
	"testing"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)
func BenchmarkTable(b *testing.B) {
	benchmarks := []struct {
		name    string
		request string
	}{
		{
			name:    "Agus",
			request: "Agus",
		},
		{
			name:    "Syahril",
			request: "Syahril",
		},
		{
			name:    "AgusSyahrilMubarok",
			request: "Agus Syahril Mubarok",
		},
		{
			name:    "Budi",
			request: "Budi Nugraha",
		},
	}

	for _, benchmark := range benchmarks {
		b.Run(benchmark.name, func(b *testing.B) {
			for i := 0; i < b.N; i++ {
				HelloWorld(benchmark.request)
			}
		})
	}
}
func BenchmarkSub(b *testing.B) {
	b.Run("Agus", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			HelloWorld("Agus")
		}
	})
	b.Run("Syahril", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			HelloWorld("Syahril")
		}
	})
}
func BenchmarkHelloWorld(b *testing.B) {
	for i := 0; i < b.N; i++ {
		HelloWorld("Agus")
	}
}
func BenchmarkHelloWorldSyahril(b *testing.B) {
	for i := 0; i < b.N; i++ {
		HelloWorld("Syahril")
	}
}
func TestTableHelloWorld(t *testing.T) {
	tests := []struct {
		name     string
		request  string
		expected string
	}{
		{
			name:     "Agus",
			request:  "Agus",
			expected: "Hello Agus",
		},
		{
			name:     "Syahril",
			request:  "Syahril",
			expected: "Hello Syahril",
		},
		{
			name:     "Mubarok",
			request:  "Mubarok",
			expected: "Hello Mubarok",
		},
		{
			name:     "Budi",
			request:  "Budi",
			expected: "Hello Budi",
		},
		{
			name:     "Joko",
			request:  "Joko",
			expected: "Hello Joko",
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			result := HelloWorld(test.request)
			require.Equal(t, test.expected, result)
		})
	}
}
func TestSubTest(t *testing.T) {
	t.Run("Agus", func(t *testing.T) {
		result := HelloWorld("Agus")
		require.Equal(t, "Hello Agus", result, "Result must be 'Hello Agus'")
	})
	t.Run("Syahril", func(t *testing.T) {
		result := HelloWorld("Syahril")
		require.Equal(t, "Hello Syahril", result, "Result must be 'Hello Syahril'")
	})
	t.Run("Mubarok", func(t *testing.T) {
		result := HelloWorld("Mubarok")
		require.Equal(t, "Hello Mubarok", result, "Result must be 'Hello Mubarok'")
	})
}
func TestMain(m *testing.M) {
	// before
	fmt.Println("BEFORE UNIT TEST")

	m.Run()

	// after
	fmt.Println("AFTER UNIT TEST")
}
func TestSkip(t *testing.T) {
	if runtime.GOOS == "darwin" {
		t.Skip("Can not run on Mac OS")
	}

	result := HelloWorld("Agus")
	require.Equal(t, "Hello Agus", result, "Result must be 'Hello Agus'")
}
func TestHelloWorldRequire(t *testing.T) {
	result := HelloWorld("Agus")
	require.Equal(t, "Hello Agus", result, "Result must be Hello Agus")
	fmt.Println("TestHelloWorldAssert with Assert Done")
}
func TestHelloWorldAssert(t *testing.T) {
	result := HelloWorld("Agus")
	assert.Equal(t, "Hello Agus", result, "Result must be Hello Agus")
	fmt.Println("TestHelloWorldAssert with Assert Done")
}
func TestHelloWorldAgus(t *testing.T) {
	result := HelloWorld("Agus")

	if result != "Hello Agus" {
		// error
		t.Error("Result must be 'Hello Agus'")
	}

	fmt.Println("TestHelloWorldAgus Done")
}
func TestHelloWorldSyahril(t *testing.T) {
	result := HelloWorld("Syahril")

	if result != "Hello Syahril" {
		// error
		t.Fatal("Result must be 'Hello Syahril'")
	}

	fmt.Println("TestHelloWorldSyahril Done")
}
func TestHelloWorldMubarok(t *testing.T) {
	result := HelloWorld("Mubarok")

	if result != "Hello Mubarok" {
		// error
		t.Fatal("Result must be 'Hello Mubarok'")
	}

	fmt.Println("TestHelloWorldMubarok Done")
}