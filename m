Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39D476D3E
	for <lists+cgroups@lfdr.de>; Thu, 16 Dec 2021 10:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhLPJTE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Dec 2021 04:19:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44300 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhLPJTE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Dec 2021 04:19:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 817CB1F45E;
        Thu, 16 Dec 2021 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639646342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rSmtMs4D/JMgdDSMfUX2HHXghuzhz3dXnYIHGOrCvIE=;
        b=ZYRquT7w/sYhdd9nS/Jw484q+HHCO55WvkA2cWVmui6nm4c72iQb8r0c3s0IqBVotyADay
        itkgxzc+bsXlEOaoTY841FC7HivasogpzrSLz+hjgior+Tg3hL6PIGOa1UD5wbCFbsxcfD
        peX3wzUigyNTyUyonZq3/0tiXN2OZDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639646342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rSmtMs4D/JMgdDSMfUX2HHXghuzhz3dXnYIHGOrCvIE=;
        b=9KCZzAFwVEmzRi97GXUbGa+7/wo2edOGm5ye9yAA2u98sFHTfmatiOoLOIPRTH48K7/Bkq
        DuxL1c4mixmO7WAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01F1E13C1F;
        Thu, 16 Dec 2021 09:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id taJdO4UEu2FwXQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Dec 2021 09:19:01 +0000
Message-ID: <956d76e5-a319-7e3d-14b9-af5106b5333f@suse.cz>
Date:   Thu, 16 Dec 2021 10:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Content-Language: en-US
To:     Roman Gushchin <guro@fb.com>
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
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <Ybk+0LKrsAJatILE@carbon.dhcp.thefacebook.com>
 <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/16/21 00:38, Roman Gushchin wrote:
> On Tue, Dec 14, 2021 at 05:03:12PM -0800, Roman Gushchin wrote:
>> On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
>> > On 12/1/21 19:14, Vlastimil Babka wrote:
>> > > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
>> > > this cover letter.
>> > > 
>> > > Series also available in git, based on 5.16-rc3:
>> > > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
>> > 
>> > Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
>> > and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
>> 
>> Hi Vlastimil!
>> 
>> I've started to review this patchset (btw, a really nice work, I like
>> the resulting code way more). Because I'm looking at v3 and I don't have

Thanks a lot, Roman!

...

> 
> * mm/slab: Convert most struct page to struct slab by spatch
> 
> Another patch with the same title? Rebase error?
> 
> * mm/slab: Finish struct page to struct slab conversion
> 
> And this one too?

No, these are for mm/slab.c, the previous were for mm/slub.c :)

> 
> Thanks!
> 
> Roman

