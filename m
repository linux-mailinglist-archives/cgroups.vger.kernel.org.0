Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D523047456D
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 15:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhLNOni (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 09:43:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32832 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbhLNOnh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 09:43:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A8DD1F37C;
        Tue, 14 Dec 2021 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639493016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZrdz8Rcb4mC0T+W0Se7DGbnZYarK1D3VtykBkZsxzg=;
        b=EA5SlD72MoprmPOYuWB0TBd0mQWMStIAMPw0q8OXQEfFDTNCjBzCswijew0sm3VG5iRCnQ
        cFse2rrr4bC7T2QaxPiIz5eQFASktG8vWNcvWtRCIijeDE6jQz0m8UR+/xMLiyQpBoeCOv
        QDr9zYbdy6FMlwtJa5nk7fdb56GrTtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639493016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZrdz8Rcb4mC0T+W0Se7DGbnZYarK1D3VtykBkZsxzg=;
        b=yAE+ZakutT0JG1tHE5b5QjagnVpFsoYUFzWqdFeP1c0gvkBTCTyG9OTtNoV9QS7VfhvBrK
        XnVExmz6AsfpTYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCFBB13DF1;
        Tue, 14 Dec 2021 14:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TiQ7MZetuGFKTwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Dec 2021 14:43:35 +0000
Message-ID: <87584294-b1bc-aabe-d86a-1a8b93a7f4d4@suse.cz>
Date:   Tue, 14 Dec 2021 15:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        patches@lists.linux.dev, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, cgroups@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        kasan-dev@googlegroups.com, Lu Baolu <baolu.lu@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <20211214143822.GA1063445@odroid>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211214143822.GA1063445@odroid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/14/21 15:38, Hyeonggon Yoo wrote:
> On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
>> On 12/1/21 19:14, Vlastimil Babka wrote:
>> > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
>> > this cover letter.
>> > 
>> > Series also available in git, based on 5.16-rc3:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
>> 
>> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
>> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
>> 
> 
> Hello Vlastimil, Thank you for nice work.
> I'm going to review and test new version soon in free time.

Thanks!

> Btw, I gave you some review and test tags and seems to be missing in new
> series. Did I do review/test process wrongly? It's first time to review
> patches so please let me know if I did it wrongly.

You did right, sorry! I didn't include them as those were for patches that I
was additionally changing after your review/test and the decision what is
substantial change enough to need a new test/review is often fuzzy. So if
you can recheck the new versions it would be great and then I will pick that
up, thanks!

> --
> Thank you.
> Hyeonggon.

