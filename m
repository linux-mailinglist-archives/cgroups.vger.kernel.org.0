Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9635742EC4
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2019 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfFLSgA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jun 2019 14:36:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35522 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFLSgA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jun 2019 14:36:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so19602925qto.2
        for <cgroups@vger.kernel.org>; Wed, 12 Jun 2019 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ccd2Dl/s5BEnRCE+LL0hkZ64UWDD7pEB/PZyv8yO8ZY=;
        b=IcABX1nM51p2QrQVsut+vh/j10d5dr6geQ+a/RrmE6DOHq7udCPilWtmRYD99j0boR
         ov5Ysub7+GqF4lbZDxDthsXnWeXk+ES3UVFuSCse5kakCEymFY4P7BJeaa1eqMTm9m4J
         a+/2xER8DdWKm0/0yHAUhnmEJWAiez71uz/DfX4C+ZMkDAyMe9n6LHO40E10deKj4zJN
         Wel0wmmIihoR/AvHw5HUgRWq+VZtm2o2vy9xdx+v9Lo1iXmV5/ZbXP3K7XF07He5wGRh
         eTLt9p7wJXVFha1pn5wg6b5vpyG2Z/ZLgk4Y4y0kGDJ+N6XDcakHacAueyHQQONRObHL
         LFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ccd2Dl/s5BEnRCE+LL0hkZ64UWDD7pEB/PZyv8yO8ZY=;
        b=jiXvrqo3uzRKFPmXA2JJIrpBUjo+nRv5csbgA5LIX2V9xYj9H3hZ+YOR6NTPeyDOSq
         IYcJ+YIVKo+e2WBf9EZziCW+8jsxKug5mpvYmQYpvvHUyYlM5pce9iS1YhcDTLTQXID6
         P+/WhKzBSxyzKzVgcPTR0vN/3w1YuVzBbFmhmi4vXiCU9YBIQzjcqg2DsAwWfDSgTngl
         SNfmVJU6eKyyrqA42P7PWDob1lCoSYfARn7sESSBPMstOSYUr0gwW3W2kzot4h3tflXS
         z2Y9XbqbBzhtXWVdZOkub3IU8RP4aaRcWDI3mpsNE56BdaQy02oHeFVsPORetJ0iwX+i
         pzmA==
X-Gm-Message-State: APjAAAVzJKlTnt2o53iJC+INIGwQUUPuIPsR3QuzN7il/+q9FZjQ8NaA
        8pz9FifW7wusFzPKoEf0qlujLg==
X-Google-Smtp-Source: APXvYqxVhJgr9VMk6UTsEjd7fGkQxdE+ShlHGLoBskD9CcIJfDIiuN/yiHxzbH4RhCcTZeh0Ja2AHg==
X-Received: by 2002:a0c:fde3:: with SMTP id m3mr136658qvu.205.1560364559359;
        Wed, 12 Jun 2019 11:35:59 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t67sm224679qkf.34.2019.06.12.11.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 11:35:58 -0700 (PDT)
Message-ID: <1560364557.5154.2.camel@lca.pw>
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
From:   Qian Cai <cai@lca.pw>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mhocko@kernel.org, linux-mm@kvack.org, vdavydov.dev@gmail.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 12 Jun 2019 14:35:57 -0400
In-Reply-To: <20190612065728.GB4761@rapoport-lnx>
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
         <20190604142338.GC24467@lakrids.cambridge.arm.com>
         <20190610114326.GF15979@fuggles.cambridge.arm.com>
         <1560187575.6132.70.camel@lca.pw>
         <20190611100348.GB26409@lakrids.cambridge.arm.com>
         <20190611124118.GA4761@rapoport-lnx>
         <3F6E1B9F-3789-4648-B95C-C4243B57DA02@lca.pw>
         <20190612065728.GB4761@rapoport-lnx>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 2019-06-12 at 09:57 +0300, Mike Rapoport wrote:
> Hi,
> 
> On Tue, Jun 11, 2019 at 08:46:45AM -0400, Qian Cai wrote:
> > 
> > > On Jun 11, 2019, at 8:41 AM, Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > 
> > > Sorry for the delay, I'm mostly offline these days.
> > > 
> > > I wanted to understand first what is the reason for the failure. I've
> > > tried
> > > to reproduce it with qemu, but I failed to find a bootable configuration
> > > that will have PGD_SIZE != PAGE_SIZE :(
> > > 
> > > Qian Cai, can you share what is your environment and the kernel config?
> > 
> > https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> > 
> > # lscpu
> > Architecture:        aarch64
> > Byte Order:          Little Endian
> > CPU(s):              256
> > On-line CPU(s) list: 0-255
> > Thread(s) per core:  4
> > Core(s) per socket:  32
> > Socket(s):           2
> > NUMA node(s):        2
> > Vendor ID:           Cavium
> > Model:               1
> > Model name:          ThunderX2 99xx
> > Stepping:            0x1
> > BogoMIPS:            400.00
> > L1d cache:           32K
> > L1i cache:           32K
> > L2 cache:            256K
> > L3 cache:            32768K
> > NUMA node0 CPU(s):   0-127
> > NUMA node1 CPU(s):   128-255
> > Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> > cpuid asimdrdm
> > 
> > # dmidecode
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >         Manufacturer: HPE
> >         Product Name: Apollo 70             
> >         Version: X1
> >         Wake-up Type: Power Switch
> >         Family: CN99XX
> > 
> 
> Can you please also send the entire log when the failure happens?

https://cailca.github.io/files/dmesg.txt

> Another question, is the problem exist with PGD_SIZE == PAGE_SIZE?

No.
