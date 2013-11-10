from .common import *
from av.audio.format import AudioFormat


postfix = 'le' if sys.byteorder == 'little' else 'be'


class TestAudioFormats(TestCase):

    def test_s16_inspection(self):
        fmt = AudioFormat('s16')
        self.assertEqual(fmt.name, 's16')
        self.assertFalse(fmt.is_planar)
        self.assertEqual(fmt.bits, 16)
        self.assertEqual(fmt.bytes, 2)
        self.assertEqual(fmt.container_name, 's16' + postfix)
        self.assertEqual(fmt.alt_planar.name, 's16p')
        self.assertIs(fmt.alt_packed, fmt)

    def test_s32p_inspection(self):
        fmt = AudioFormat('s32p')
        self.assertEqual(fmt.name, 's32p')
        self.assertTrue(fmt.is_planar)
        self.assertEqual(fmt.bits, 32)
        self.assertEqual(fmt.bytes, 4)
        self.assertRaises(ValueError, lambda: fmt.container_name)
