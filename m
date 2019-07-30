Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F37AD3F
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2019 18:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfG3QG5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Jul 2019 12:06:57 -0400
Received: from mail.univention.de ([82.198.197.8]:2860 "EHLO
        mail.univention.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfG3QG5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Jul 2019 12:06:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by solig.knut.univention.de (Postfix) with ESMTP id 6EE6268E237B;
        Tue, 30 Jul 2019 18:06:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.10.1 (20141025) (Debian) at
        knut.univention.de
Received: from mail.univention.de ([127.0.0.1])
        by localhost (solig.knut.univention.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 856GgQEuhQX9; Tue, 30 Jul 2019 18:06:51 +0200 (CEST)
Received: from [192.168.0.222] (mail.univention.de [82.198.197.8])
        by solig.knut.univention.de (Postfix) with ESMTPSA id D187968E2369;
        Tue, 30 Jul 2019 18:06:51 +0200 (CEST)
Subject: Re: Bug#931111: linux-image-4.9.0-9: Memory "leak" caused by CGroup
 as used by pam_systemd
To:     Roman Gushchin <guro@fb.com>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        "931111@bugs.debian.org" <931111@bugs.debian.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        =?UTF-8?B?5q6154aK5pil?= <duanxiongchun@bytedance.com>
References: <156154446841.16461.12659721223363969171.reportbug@fixa.knut.univention.de>
 <ad0222ca-5fb0-4177-dc82-ca63f079e942@univention.de>
 <aa31aa4f4f6c05df3f52f4bd99ceb6f0341ff482.camel@decadent.org.uk>
 <ad6a6d63-b61d-45c2-36f4-e7761bb58a3d@univention.de>
 <20190724144137.GB11425@castle.DHCP.thefacebook.com>
From:   Philipp Hahn <hahn@univention.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hahn@univention.de; prefer-encrypt=mutual; keydata=
 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
 E57YS6NHln5zGC8hHrOFsw==
Organization: Univention GmbH
Message-ID: <5c3dff05-3c32-19b8-d89e-f58ff123855b@univention.de>
Date:   Tue, 30 Jul 2019 18:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724144137.GB11425@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Am 24.07.19 um 16:41 schrieb Roman Gushchin:
> On Wed, Jul 24, 2019 at 09:12:50AM +0200, Philipp Hahn wrote:
>> Am 24.07.19 um 00:03 schrieb Ben Hutchings:
...
>>> I would say this is a kernel bug.  I think it's the same problem that
>>> this patch series is trying to solve:
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_ml_linux-2Dkernel_20190611231813.3148843-2D1-2Dguro-40fb.com_&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=xNLFAB3gBGB1NCKmQZN-6JNEj_AXfJ3-wYK7IDWJAx4&s=YfWWnoW-zJdTN0hd1tzzZQlUIUtjv-iBN9Co5rNP5J0&e= 
>>>
>>> Does the description there seem to match what you're seeing?
>>
>> Yes, Roman Gushchin replied to me by private mail, which I will quote
>> here to get his response archived in Debian's BTS as well:
...
>>> I've spent lot of time working on this problem, and the final patchset
>>> has been merged into 5.3. It implements reparenting of the slab memory
>>> on cgroup deletion. 5.3 should be much better in reclaiming dying cgroups.
>>>
>>> Unfortunately, the patchset is quite invasive and is based on some
>>> vmstats changes from 5.2, so it's not trivial to backport it to
>>> older kernels.
>>>
>>> Also, there is no good workaround, only manually dropping kernel
>>> caches or disable the kernel memory accounting as a whole.
...
>> So should someone™ bite the bullet and try to backport Romans change to
>> 4.19 (and 4.9)? (those are the kernel versions used by Debian).
>> I'm not a kernel expert myself, especially no mm/cg expert, but have
>> done some work myself in the past, but I would happily pass on the
>> chalice to someone more experienced.
> 
> It's doable from the technical point of view, but I really doubt it's suitable
> for the official stable. The backport will consist of at least 20+ core
> mm/memcontrol patches, so it really feels excessive.
> 
> If you still want to try, you need to backport 205b20cc5a99 first (and the rest
> of the patchset), but it may also depend on some other vmstat changes.

I haven't yet started on trying the backport, but is there some process
to force free those dying cgroups manually?

I have found yet another report of this issue at
<https://github.com/moby/moby/issues/29638#issuecomment-514287415> and
there a cron-job

> 6 */12 * * * root echo 3 > /proc/sys/vm/drop_caches

is recommended. I tried that manually on one of our affected systems and
the number of memory cgroups only dropped marginally from 211_620 to
210_396 after doing the `drop_caches` multiple times and waiting for 10
minutes by now. On that idle system a lot of RAM is gone:
> # free -h
>               total        used        free      shared  buff/cache   available
> Mem:           141G         60G         80G         15M        755M         80G

Thanks again for all your help.

Philipp
