Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22A57FFFD
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436875AbfHBSD4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 14:03:56 -0400
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:44724 "EHLO
        nwk-aaemail-lapp01.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406516AbfHBSDz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Aug 2019 14:03:55 -0400
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
        by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id x72I2i8I024930;
        Fri, 2 Aug 2019 11:03:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=sender : from :
 message-id : content-type : mime-version : subject : date : in-reply-to :
 cc : to : references; s=20180706;
 bh=80RiGYlb2lZmQyoKG/DO907OxXkRaP9j7SLE8skLiac=;
 b=S6gNFhuY/LGI3NWYeUu+WRgPSWmJUE5vdrUuvsnlAPcjcTVtGjYrYSxdVQENDUAR2ayk
 UgdL/sbsZ6uJdYG6/vcvx5UpaiIYkJQNH9L3X1O5judfhRAvRwaQmk5+NZnqwazRSd83
 HF5/yD6ocQunV78P7r0ASWarTz89NmKbMIgZwfJJ0FK8dtZkHXpj7DJ0bT3PvDnVhpEJ
 CCS3eecPMUCeD+yJ+n6/urzxEX5YJalp+CT4dj/QMHAMPhAKYQTPZ3ClJoR57L/WE881
 /Kq5nfrXsWLGqeb7CaIeP2I36sQRe1lmjUDNXMcdQ8ywfCr98QLd0WdyN57nWulsyidz /Q== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp01.apple.com with ESMTP id 2u412dm2ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 02 Aug 2019 11:03:49 -0700
Received: from nwk-mmpp-sz10.apple.com
 (nwk-mmpp-sz10.apple.com [17.128.115.122]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0PVM00EJKFIDHIB0@mr2-mtap-s03.rno.apple.com>; Fri,
 02 Aug 2019 11:03:49 -0700 (PDT)
Received: from process_milters-daemon.nwk-mmpp-sz10.apple.com by
 nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0PVM00100FH4OZ00@nwk-mmpp-sz10.apple.com>; Fri,
 02 Aug 2019 11:03:49 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: d66bf338104d7316df20fe4640a3b0ba
X-Va-E-CD: b03d5acee32fc9f0c9dfd3776592dc73
X-Va-R-CD: 1835f3c54d533384876758843bc94ede
X-Va-CD: 0
X-Va-ID: e4d19e26-edb9-4f12-9f7e-f79d79cb3b2f
X-V-A:  
X-V-T-CD: d66bf338104d7316df20fe4640a3b0ba
X-V-E-CD: b03d5acee32fc9f0c9dfd3776592dc73
X-V-R-CD: 1835f3c54d533384876758843bc94ede
X-V-CD: 0
X-V-ID: b25c08a9-7b10-458c-b61f-bd2d82518d8f
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-08-02_07:,, signatures=0
Received: from iceman.apple.com (iceman.apple.com [17.228.212.91])
 by nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0PVM00MF9FDJJE90@nwk-mmpp-sz10.apple.com>; Fri,
 02 Aug 2019 11:00:55 -0700 (PDT)
From:   Masoud Sharbiani <msharbiani@apple.com>
Message-id: <5DE6F4AE-F3F9-4C52-9DFC-E066D9DD5EDC@apple.com>
Content-type: multipart/signed;
 boundary="Apple-Mail=_8F970ECA-B159-4BBD-8C17-D483AF218472";
 protocol="application/pkcs7-signature"; micalg=sha-256
MIME-version: 1.0 (Mac OS X Mail 13.0 \(3570.1\))
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Date:   Fri, 02 Aug 2019 11:00:55 -0700
In-reply-to: <20190802144110.GL6461@dhcp22.suse.cz>
Cc:     gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michal Hocko <mhocko@kernel.org>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
 <20190802074047.GQ11627@dhcp22.suse.cz>
 <7E44073F-9390-414A-B636-B1AE916CC21E@apple.com>
 <20190802144110.GL6461@dhcp22.suse.cz>
X-Mailer: Apple Mail (2.3570.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-AD-Result: pass
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--Apple-Mail=_8F970ECA-B159-4BBD-8C17-D483AF218472
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Aug 2, 2019, at 7:41 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> On Fri 02-08-19 07:18:17, Masoud Sharbiani wrote:
>>=20
>>=20
>>> On Aug 2, 2019, at 12:40 AM, Michal Hocko <mhocko@kernel.org> wrote:
>>>=20
>>> On Thu 01-08-19 11:04:14, Masoud Sharbiani wrote:
>>>> Hey folks,
>>>> I=E2=80=99ve come across an issue that affects most of 4.19, 4.20 =
and 5.2 linux-stable kernels that has only been fixed in 5.3-rc1.
>>>> It was introduced by
>>>>=20
>>>> 29ef680 memcg, oom: move out_of_memory back to the charge path=20
>>>=20
>>> This commit shouldn't really change the OOM behavior for your =
particular
>>> test case. It would have changed MAP_POPULATE behavior but your =
usage is
>>> triggering the standard page fault path. The only difference with
>>> 29ef680 is that the OOM killer is invoked during the charge path =
rather
>>> than on the way out of the page fault.
>>>=20
>>> Anyway, I tried to run your test case in a loop and leaker always =
ends
>>> up being killed as expected with 5.2. See the below oom report. =
There
>>> must be something else going on. How much swap do you have on your
>>> system?
>>=20
>> I do not have swap defined.=20
>=20
> OK, I have retested with swap disabled and again everything seems to =
be
> working as expected. The oom happens earlier because I do not have to
> wait for the swap to get full.
>=20

In my tests (with the script provided), it only loops 11 iterations =
before hanging, and uttering the soft lockup message.


> Which fs do you use to write the file that you mmap?

/dev/sda3 on / type xfs =
(rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=3D32k,noquota)

Part of the soft lockup path actually specifies that it is going through =
__xfs_filemap_fault():

[  561.452933] watchdog: BUG: soft lockup - CPU#4 stuck for 22s! =
[leaker:3261]
[  561.459904] Modules linked in: dm_mirror dm_region_hash dm_log dm_mod =
iTCO_wdt gpio_ich iTCO_vendor_support dcdbas ipmi_ssif intel_powerc
lamp coretemp kvm_intel ses ipmi_si kvm enclosure scsi_transport_sas =
ipmi_devintf irqbypass pcspkr lpc_ich sg joydev ipmi_msghandler wmi acp
i_power_meter acpi_cpufreq xfs libcrc32c ata_generic sd_mod pata_acpi =
ata_piix libata megaraid_sas crc32c_intel serio_raw bnx2 bonding
[  561.495979] CPU: 4 PID: 3261 Comm: leaker Tainted: G          I  L    =
5.3.0-rc2+ #10
[  561.503704] Hardware name: Dell Inc. PowerEdge R710/0YDJK3, BIOS =
6.4.0 07/23/2013
[  561.511168] RIP: 0010:lruvec_lru_size+0x49/0xf0
[  561.515687] Code: 41 89 ed b8 ff ff ff ff 45 31 f6 49 c1 e5 03 eb 19 =
48 63 d0 4c 89 e9 48 03 8b 88 00 00 00 48 8b 14 d5 60 a9 92 94 4c 03
 34 11 <48> c7 c6 80 7c bf 94 89 c7 e8 89 d3 59 00 3b 05 27 eb ff 00 72 =
d1
[  561.534418] RSP: 0018:ffffb5f886a3f640 EFLAGS: 00000246 ORIG_RAX: =
ffffffffffffff13
[  561.541968] RAX: 0000000000000002 RBX: ffff96fca3bba400 RCX: =
00003ef5d82059f0
[  561.549085] RDX: ffff9702a7a40000 RSI: 0000000000000010 RDI: =
ffffffff94bf7c80
[  561.556202] RBP: 0000000000000001 R08: 0000000000000000 R09: =
ffffffff94ae1c00
[  561.563318] R10: ffff96fcc7802520 R11: 0000000000000000 R12: =
0000000000000004
[  561.570435] R13: 0000000000000008 R14: 0000000000000000 R15: =
0000000000000000
[  561.577553] FS:  00007f5522602740(0000) GS:ffff9702a7a80000(0000) =
knlGS:0000000000000000
[  561.585623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  561.591352] CR2: 00007fba755f95b0 CR3: 0000000c646dc000 CR4: =
00000000000006e0
[  561.598468] Call Trace:
[  561.600907]  shrink_node_memcg+0xc8/0x790
[  561.604905]  ? shrink_slab+0x245/0x280
[  561.608644]  ? mem_cgroup_iter+0x10a/0x2c0
[  561.612728]  shrink_node+0xcd/0x490
[  561.616208]  do_try_to_free_pages+0xda/0x3a0
[  561.620466]  ? mem_cgroup_select_victim_node+0x43/0x2f0
[  561.625678]  try_to_free_mem_cgroup_pages+0xe7/0x1c0
[  561.630629]  try_charge+0x246/0x7a0
[  561.634107]  mem_cgroup_try_charge+0x6b/0x1e0
[  561.638453]  ? mem_cgroup_commit_charge+0x5a/0x110
[  561.643231]  __add_to_page_cache_locked+0x195/0x330
[  561.648100]  ? scan_shadow_nodes+0x30/0x30
[  561.652184]  add_to_page_cache_lru+0x39/0xa0
[  561.656442]  iomap_readpages_actor+0xf2/0x230
[  561.660787]  iomap_apply+0xa3/0x130
[  561.664266]  iomap_readpages+0x97/0x180
[  561.668091]  ? iomap_migrate_page+0xe0/0xe0
[  561.672266]  read_pages+0x57/0x180
[  561.675657]  __do_page_cache_readahead+0x1ac/0x1c0
[  561.680436]  ondemand_readahead+0x168/0x2a0
[  561.684606]  filemap_fault+0x30d/0x830
[  561.688343]  ? flush_tlb_func_common.isra.8+0x147/0x230
[  561.693554]  ? __mod_lruvec_state+0x40/0xe0
[  561.697726]  ? alloc_set_pte+0x4e6/0x5b0
[  561.701669]  __xfs_filemap_fault+0x61/0x190 [xfs]
[  561.706361]  __do_fault+0x38/0xb0
[  561.709666]  __handle_mm_fault+0xbee/0xe90
[  561.713750]  handle_mm_fault+0xe2/0x200
[  561.717574]  __do_page_fault+0x224/0x490
[  561.721485]  do_page_fault+0x31/0x120
[  561.725137]  page_fault+0x3e/0x50
[  561.728439] RIP: 0033:0x400c5a
[  561.731483] Code: 45 c0 48 89 c6 bf 77 0e 40 00 b8 00 00 00 00 e8 3c =
fb ff ff c7 45 dc 00 00 00 00 eb 36 8b 45 dc 48 63 d0 48 8b 45 c0 48
 01 d0 <0f> b6 00 0f be c0 01 45 e8 8b 45 dc 25 ff 0f 00 00 85 c0 75 10 =
8b
[  561.750214] RSP: 002b:00007fffba1d9450 EFLAGS: 00010206
[  561.755426] RAX: 00007f550346b000 RBX: 0000000000000000 RCX: =
000000000000001a
[  561.762542] RDX: 0000000001c4c000 RSI: 000000007fffffe5 RDI: =
0000000000000000
[  561.769659] RBP: 00007fffba1da4a0 R08: 0000000000000000 R09: =
00007f552206c20d
[  561.776775] R10: 0000000000000002 R11: 0000000000000246 R12: =
0000000000400850
[  561.783892] R13: 00007fffba1da580 R14: 0000000000000000 R15: =
0000000000000000


If I switch the backing file to a ext4 filesystem (separate hard drive), =
it OOMs.


If I switch the file used to /dev/zero, it OOMs:=20
=E2=80=A6
Todal sum was 0. Loop count is 11
Buffer is @ 0x7f2b66c00000
./test-script-devzero.sh: line 16:  3561 Killed                  =
./leaker -p 10240 -c 100000


> Or could you try to
> simplify your test even further? E.g. does everything work as expected
> when doing anonymous mmap rather than file backed one?

It also OOMs with MAP_ANON.=20

Hope that helps.
Masoud


> --=20
> Michal Hocko
> SUSE Labs


--Apple-Mail=_8F970ECA-B159-4BBD-8C17-D483AF218472
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

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
Y2E1ZzEuZGVyMDgGCCsGAQUFBzABhixodHRwOi8vb2NzcC5hcHBsZS5jb20vb2NzcDAzLWFwcGxl
aXN0Y2E1ZzEwMTAfBgNVHREEGDAWgRRtc2hhcmJpYW5pQGFwcGxlLmNvbTCCASoGA1UdIASCASEw
ggEdMIIBGQYLKoZIhvdjZAULBQEwggEIMIHKBggrBgEFBQcCAjCBvQyBulJlbGlhbmNlIG9uIHRo
aXMgY2VydGlmaWNhdGUgYXNzdW1lcyBhY2NlcHRhbmNlIG9mIGFueSBhcHBsaWNhYmxlIHRlcm1z
IG9mIHVzZSBhbmQgY2VydGlmaWNhdGlvbiBwcmFjdGljZSBzdGF0ZW1lbnRzLiBUaGlzIGNlcnRp
ZmljYXRlIHNoYWxsIG5vdCBzZXJ2ZSBhcywgb3IgcmVwbGFjZSBhIHdyaXR0ZW4gc2lnbmF0dXJl
LjA5BggrBgEFBQcCARYtaHR0cDovL3d3dy5hcHBsZS5jb20vY2VydGlmaWNhdGVhdXRob3JpdHkv
cnBhMBMGA1UdJQQMMAoGCCsGAQUFBwMEMDcGA1UdHwQwMC4wLKAqoCiGJmh0dHA6Ly9jcmwuYXBw
bGUuY29tL2FwcGxlaXN0Y2E1ZzEuY3JsMB0GA1UdDgQWBBR5OmXQsx80at576fQVWG/05OardjAO
BgNVHQ8BAf8EBAMCBaAwDQYJKoZIhvcNAQELBQADggEBAMavb8+8hvTGbqNfz0g9P4Alj5YKpTnW
pt1NNuyl9qR+QVooK8oMbGTB6cbSSKX7lcAW7motP5eRF0EiKXiu+IIgPhmDWKkbKnrrWK9AGhVn
xpm3OCnRHt2b+zYbkGGty0HYncIRdy3acTr+0T9Vs4xANJHwBIqUnkW5XKbPiZkv+EVKAsnL5CYD
npLI/uslfLquUYe6o8XIBVNYhmxEcxeCXbeESEk/KutdL+JcV4SpNoEB6Y4Dk1ZnHYOZRiLV3ZEG
neaCYYxam7SPWxeXqLtgeQMEEPgqj6pj430BQ/NKmCqdwRv2Sd0wXlKEDMul7jmWVUiRd6Nijgy5
7E2hn9MxggMgMIIDHAIBATB2MGIxHDAaBgNVBAMTE0FwcGxlIElTVCBDQSA1IC0gRzExIDAeBgNV
BAsTF0NlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMwEQYDVQQKEwpBcHBsZSBJbmMuMQswCQYDVQQG
EwJVUwIQDNpHL/RwufOMyUmvGQQ2czANBglghkgBZQMEAgEFAKCCAXswGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwODAyMTgwMDU1WjAvBgkqhkiG9w0BCQQxIgQg
ysoC6Rc5l68fyfKoRNP4sHQg/7Nw57uDIarHWYvjgsYwgYUGCSsGAQQBgjcQBDF4MHYwYjEcMBoG
A1UEAxMTQXBwbGUgSVNUIENBIDUgLSBHMTEgMB4GA1UECxMXQ2VydGlmaWNhdGlvbiBBdXRob3Jp
dHkxEzARBgNVBAoTCkFwcGxlIEluYy4xCzAJBgNVBAYTAlVTAhAM2kcv9HC584zJSa8ZBDZzMIGH
BgsqhkiG9w0BCRACCzF4oHYwYjEcMBoGA1UEAxMTQXBwbGUgSVNUIENBIDUgLSBHMTEgMB4GA1UE
CxMXQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxEzARBgNVBAoTCkFwcGxlIEluYy4xCzAJBgNVBAYT
AlVTAhAM2kcv9HC584zJSa8ZBDZzMA0GCSqGSIb3DQEBAQUABIIBAIxwLUajIXJLd4oNyXmj8zza
wHSboRB3c3eCayvn8mS+W537w4o+gMKJAlxK1RnshpehkqdHMQk+p3RzDM1Cd9QPPwcILarC25lv
P/e/HO21VtILzXMbtc9P8fD1th2ZfaU+xDzW0d2FgYj+Semknk0LPfnRBBENVbiDDpIQuLndjEOG
wiA2WN99hqXNbAVTAapDoSwF26km7b6Kc4qFoIykorWBtbLwtTscprAOjrLbiz6zqgtc3Lwuu6Dj
hj6o4agTJbAmYlObtTlA4eNkWYKeentNGsHpw1THJYqdY+pjBJFQlyTZb8DNpnDDavfLDT1kigw7
L3sClsUG/hHGmPMAAAAAAAA=
--Apple-Mail=_8F970ECA-B159-4BBD-8C17-D483AF218472--
