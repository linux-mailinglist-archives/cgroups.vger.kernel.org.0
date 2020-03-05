Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1817A65B
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 14:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCEN2Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 08:28:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44921 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCEN2Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 08:28:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id d9so2638010plo.11;
        Thu, 05 Mar 2020 05:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bhx+NBdKqY66XB2XWeinrI4DDBX+xbxLxkCNi2ZSM60=;
        b=sgKQNZHQ1JV9YlLIBaur6OHIznYyeVhIl9wcnbLhCbPWqkgsRQFXa28uDXbQGfVOkW
         vUqTINwdRMU+LuFu7U03b++x4DxtY58gjMl+2Jg5aXx/hlFSBDWvVCZWLmCX9IM/6gsP
         NFk/qJa+I/S31cs1qf1R1+EwwxobxdP+WmNx9H76or9vLkRIdv28s32bzHB9H4l4A67h
         PbrXquzbjrkjqF1gvZIYp/T2vAz9nWTWiREFy1BDpKUJacclV7Qt3dzEhQZy6UMeAbxr
         OQ/ln4qwVPAF9Bu3YeYq5wwD8urCmdr5tL//iG//8SvI6JM3QP34Qaj+K0KBCtxQ1hbH
         9u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bhx+NBdKqY66XB2XWeinrI4DDBX+xbxLxkCNi2ZSM60=;
        b=Txg5T/IRb9vaqQ98vwtOlhycYDTwh01IuUo/USJavXMIxh1rx3T9khYO0f3Wh/bnfN
         ORFx7aMfgPBAaDmUDbOD/cJPMlswoAy4KIiXJD1FCPUR9jigOgIjnBwEpvWn5qtWX0P1
         eD1K9SUlF2WiGsihF6FV/qQUuaWhP1Uv5elzVDSUtRBZhkvjLD4xIvM40Z8r/12xuGtK
         vy6sNTLgvu+YSFUqz/kMgxfDx7OLXcEfa1JmmPL3ilZgVRv2RmZ8uiYo/qytR4jkqoRS
         DxMmNKiwaxymCD5MpFQA2DUhoGjIfK39VIa7Z5JJNFRj/ZtQpATB2xlniGCoGUTxUZJ1
         Kqng==
X-Gm-Message-State: ANhLgQ0Ahu35KJKiF7QzCi7O28Tdf4ftwyVHIkMswpjld89lIGNQ+vvh
        8Zylk+qfTr7/o1mefixZ9UUbd/P1
X-Google-Smtp-Source: ADFU+vvF1wTj9Tk1NLRkUINz3py3w9Oy5Pixy5Y2Hm0XtsNFSE8Qr0gmY7l4M3gr1aTX4w2a/JR2FQ==
X-Received: by 2002:a17:90a:1912:: with SMTP id 18mr7935609pjg.124.1583414902895;
        Thu, 05 Mar 2020 05:28:22 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id mn19sm6447589pjb.39.2020.03.05.05.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 05:28:22 -0800 (PST)
Subject: Re: [PATCH] memcg: fix NULL pointer dereference in
 __mem_cgroup_usage_unregister_event
To:     Michal Hocko <mhocko@kernel.org>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <5ee35fe7-2a90-ae71-9100-3f2833cbf252@gmail.com>
 <20200305092447.GQ16139@dhcp22.suse.cz>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <1391a759-845e-11d4-09f4-9bd6e498db4f@gmail.com>
Date:   Thu, 5 Mar 2020 21:28:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305092447.GQ16139@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sorry, the calltrace in the email is from the old system, i will fix it l=
ater. this problem also exists in the latest master branch. The
following is the calltrace corresponding to the latest kernel:

[=C2=A0 135.675108] BUG: kernel NULL pointer dereference, address: 000000=
0000000004
[=C2=A0 135.675350] #PF: supervisor write access in kernel mode
[=C2=A0 135.675579] #PF: error_code(0x0002) - not-present page
[=C2=A0 135.675816] PGD 800000033058e067 P4D 800000033058e067 PUD 3355ce0=
67 PMD 0
[=C2=A0 135.676080] Oops: 0002 [#1] SMP PTI
[=C2=A0 135.676332] CPU: 2 PID: 14012 Comm: kworker/2:6 Kdump: loaded Not=
 tainted 5.6.0-rc4 #3
[=C2=A0 135.676610] Hardware name: LENOVO 20AWS01K00/20AWS01K00, BIOS GLE=
T70WW (2.24 ) 05/21/2014
[=C2=A0 135.676909] Workqueue: events memcg_event_remove
[=C2=A0 135.677192] RIP: 0010:__mem_cgroup_usage_unregister_event+0xb3/0x=
190
[=C2=A0 135.677473] Code: c0 31 d2 48 63 ca 48 c1 e1 04 4c 39 64 0e 08 0f=
 95 c1 83 c2 01 0f b6 c9 01 c8 39 fa 75 e5 85 c0 4d 8b 7d 08 0f 84 ad 00 =
00 00 <41> 89 47 04 41 c7 07 ff ff ff ff 31 c0 49 8b 4d 00 31 d2 8b 71 04=

[=C2=A0 135.677825] RSP: 0018:ffffb47e01c4fe18 EFLAGS: 00010202
[=C2=A0 135.678186] RAX: 0000000000000001 RBX: ffff8bb223a8a000 RCX: 0000=
000000000001
[=C2=A0 135.678548] RDX: 0000000000000001 RSI: ffff8bb22fb83540 RDI: 0000=
000000000001
[=C2=A0 135.678912] RBP: ffffb47e01c4fe48 R08: 0000000000000000 R09: 0000=
000000000010
[=C2=A0 135.679287] R10: 000000000000000c R11: 071c71c71c71c71c R12: ffff=
8bb226aba880
[=C2=A0 135.679670] R13: ffff8bb223a8a480 R14: 0000000000000000 R15: 0000=
000000000000
[=C2=A0 135.680066] FS:=C2=A0 0000000000000000(0000) GS:ffff8bb242680000(=
0000) knlGS:0000000000000000
[=C2=A0 135.680475] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[=C2=A0 135.680894] CR2: 0000000000000004 CR3: 000000032c29c003 CR4: 0000=
0000001606e0
[=C2=A0 135.681325] Call Trace:
[=C2=A0 135.681763]=C2=A0 memcg_event_remove+0x32/0x90
[=C2=A0 135.682209]=C2=A0 process_one_work+0x172/0x380
[=C2=A0 135.682657]=C2=A0 worker_thread+0x49/0x3f0
[=C2=A0 135.683111]=C2=A0 kthread+0xf8/0x130
[=C2=A0 135.683570]=C2=A0 ? max_active_store+0x80/0x80
[=C2=A0 135.684034]=C2=A0 ? kthread_bind+0x10/0x10
[=C2=A0 135.684506]=C2=A0 ret_from_fork+0x35/0x40
[=C2=A0 135.684981] Modules linked in: netconsole cmac xt_CHECKSUM xt_MAS=
QUERADE tun bridge stp llc ccm ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip=
6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtabl=
e_broute ip6table_nat ip6table_mangle ip6table_security ip6table_raw ipta=
ble_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle =
iptable_security iptable_raw ebtable_filter ebtables ip6table_filter ip6_=
tables iptable_filter bnep sunrpc intel_rapl_msr intel_rapl_common x86_pk=
g_temp_thermal intel_powerclamp coretemp kvm_intel kvm rtl8192cu rtl_usb =
rtl8192c_common irqbypass rtlwifi mac80211 uvcvideo snd_hda_codec_realtek=
 crct10dif_pclmul snd_hda_codec_hdmi snd_hda_codec_generic iTCO_wdt crc32=
_pclmul wmi_bmof mei_wdt iTCO_vendor_support snd_hda_intel btusb videobuf=
2_vmalloc ghash_clmulni_intel snd_intel_dspcfg btrtl videobuf2_memops snd=
_hda_codec btbcm videobuf2_v4l2 btintel snd_hda_core videobuf2_common blu=
etooth aesni_intel crypto_simd cryptd cfg80211
videodev
[=C2=A0 135.685003]=C2=A0 snd_hwdep glue_helper snd_seq mc ecdh_generic l=
ibarc4 snd_seq_device ecc pcspkr joydev snd_pcm thinkpad_acpi snd_timer l=
edtrig_audio sg i2c_i801 lpc_ich wmi snd rfkill mei_me soundcore mei ie31=
200_edac sch_fq_codel ip_tables xfs libcrc32c sr_mod sd_mod cdrom t10_pi =
i915 i2c_algo_bit drm_kms_helper crc32c_intel syscopyarea sysfillrect sys=
imgblt serio_raw fb_sys_fops drm e1000e ahci libahci video libata ptp pps=
_core dm_mirror dm_region_hash dm_log dm_mod
[=C2=A0 135.689733] CR2: 0000000000000004

We can reproduce this problem in the following ways=EF=BC=9A

1. We create a new cgroup subdirectory and a new eventfd, and then we mon=
itor multiple memory thresholds of the cgroup through this eventfd
2. closing this eventfd, the system will call __mem_cgroup_usage_unregist=
er_event () multiple times to delete all events related to this eventfd.

The first time __mem_cgroup_usage_unregister_event () is called, the syst=
em will clear all items related to this eventfd in thresholds-> primary.
Since there is currently only one eventfd, thresholds-> primary becomes e=
mpty, so the system will set thresholds-> primary and hresholds-> spare
to NULL. If at this time, the user creates a new eventfd and monitor the =
memory threshold of this cgroup, then the system will re-initialize
thresholds-> primary. Then when the system call __mem_cgroup_usage_unregi=
ster_event () is called for the second time, because thresholds-> primary=

is not empty, the system will access thresholds-> spare, but thresholds->=
 spare is NULL, which will trigger a crash.

In general, the longer it takes to delete all events related to this even=
tfd, the easier it is to trigger this problem.

thanks

Michal Hocko wrote on 2020/3/5 17:24:
> Thank you for the report!
>
> On Thu 05-03-20 13:52:03, brookxu wrote:
>> One eventfd monitors multiple memory thresholds of cgroup, closing it,=
 the
>> system will delete related events. Before all events are deleted, anot=
her
>> eventfd monitors the cgroup's memory threshold.
> Could you describe the race scenario please? Ideally=20
>> As a result, thresholds->primary[] is not empty, but thresholds->spars=
e[]
>> is NULL, __mem_cgroup_usage_unregister_event() leading to a crash:
>>
>> [=C2=A0 138.925809] BUG: unable to handle kernel NULL pointer derefere=
nce at 0000000000000004
>> [=C2=A0 138.926817] IP: [<ffffffff8116c9b7>] mem_cgroup_usage_unregist=
er_event+0xd7/0x1f0
>> [=C2=A0 138.927701] PGD 73bce067 PUD 76ff3067 PMD 0
>> [=C2=A0 138.928384] Oops: 0002 [#1] SMP
>> [=C2=A0 138.935218] CPU: 1 PID: 14 Comm: kworker/1:0 Not tainted 3.10.=
107-1-tlinux2-0047 #1
> Also you seem to be running a very old kernel. Does the problem exist i=
n
> the current Vanilla kernel?

