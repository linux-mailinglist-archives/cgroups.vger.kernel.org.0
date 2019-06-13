Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A654377E
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2019 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfFMO7Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 13 Jun 2019 10:59:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34946 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfFMOwi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 10:52:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so19252460otq.2
        for <cgroups@vger.kernel.org>; Thu, 13 Jun 2019 07:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cX5FJ+aRLK1/hJQi/LFkmdjYRZCST630rgnMW1p6Y9Q=;
        b=JmzFIV31xL3Kbdfboti9L1kTvauDnn3X/O7aKBhYSl0u7KF5i+FJMbz/EVXSwrqK28
         okUX7GWuCKa0lufMfUYIwV945RUPs+SSDSRFHDObwZfvaIpNncgIPl5or21TnQcmEXJr
         jkMN8eikFL4Jyagdmci/CBlGEvknAJbgqxudAkGG8Kj592epC1fS3E9cqemdIC/yz2GH
         9WXbQWin5rWjzJO2+TfuBMzwbv4ZPBZevcjxRqzUp+tmnTygwUo22FajngwWxEl+zHT+
         0KvbFP6yXcS4uqOvNlg7jazZmBEju0AG/5xkD44wBIstqKSaHqU69k8E4eDY7WfagvsA
         4cuw==
X-Gm-Message-State: APjAAAUp2V9r03bS9oXoAtYRNHz3L7d/o8fdom7GV77RBeV18VxM8FEv
        NEYhfUWZsw7BMtij9Kew4/tty19aVAUg4uSiCj2dAg==
X-Google-Smtp-Source: APXvYqxRB6BRxrdXY5Q3tPDTiXrspZ+X0DJKJW0lvcZsECrW6fO2C8nJipqu0uODNrCrt6ss96YP2Qradhs9HoewLK0=
X-Received: by 2002:a05:6830:1249:: with SMTP id s9mr26932374otp.33.1560437558004;
 Thu, 13 Jun 2019 07:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190409204003.6428-1-jsavitz@redhat.com> <20190521143414.GJ5307@blackbody.suse.cz>
 <CAL1p7m6nfPkWoEEAjO+Gxq-ZiRY7+1jU_7dVcw2-hjC22xz-4A@mail.gmail.com>
 <20190528121036.GC31588@blackbody.suse.cz> <20190613120228.GA26668@blackbody.suse.cz>
In-Reply-To: <20190613120228.GA26668@blackbody.suse.cz>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 13 Jun 2019 10:52:22 -0400
Message-ID: <CAL1p7m7T+ASfEd9dXEDg59XQEdp=eUE9fj5q-7hyEXat=_hL0A@mail.gmail.com>
Subject: Re: [PATCH v2] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, Phil Auld <pauld@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I just did a quick test on a patched kernel to check on that "no
longer affine to..." message:

# nproc
64

# taskset -p 4 $$
pid 2261's current affinity mask: ffffffffffffffff
pid 2261's new affinity mask: 4
# echo off > /sys/devices/system/cpu/cpu2/online
# taskset -p $$
pid 2261's current affinity mask: fffffffffffffffb
# echo on > /sys/devices/system/cpu/cpu2/online
# taskset -p $$
pid 2261's current affinity mask: ffffffffffffffff

# dmesg | tail -5
[  143.996375] process 2261 (bash) no longer affine to cpu2
[  143.996657] IRQ 114: no longer affine to CPU2
[  144.007472] IRQ 227: no longer affine to CPU2
[  144.013460] smpboot: CPU 2 is now offline
[  162.685519] smpboot: Booting Node 0 Processor 2 APIC 0x4

dmesg output is observably the same on patched and unpatched kernels
in this case.

The only difference in output is that on an unpatched kernel, the last
`taskset -p $$` outputs:
pid 2274's current affinity mask: fffffffffffffffb
Which is the behavior that this patch aims to modify

This case, which I believe is generalizable, demonstrates that we
retain the "no longer affine to..." output on a kernel with this
patch.

Best,
Joel Savitz



On Thu, Jun 13, 2019 at 8:02 AM Michal Koutný <mkoutny@suse.com> wrote:
>
> On Tue, May 28, 2019 at 02:10:37PM +0200, Michal Koutný  <MKoutny@suse.com> wrote:
> > Although, on v1 we will lose the "no longer affine to..." message
> > (which is what happens in your demo IIUC).
> FWIW, I was wrong, off by one 'state' transition. So the patch doesn't
> cause change in messaging (not tested though).
