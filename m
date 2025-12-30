Return-Path: <cgroups+bounces-12828-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B5CEAA2C
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 21:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76EA4300F5B9
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF8F2F28EF;
	Tue, 30 Dec 2025 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DjLjN4Lh"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E325C80D;
	Tue, 30 Dec 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767127907; cv=none; b=QZ4kFiCy7+IFp4eqt3VjwRWUYIVIjgMkNMoLpViURt2JP5kUW4RnKY1NP8D/lld85/npQbEw7O18f4CWp2bEp9EU8Z7HdqJt40yg9dvVkzejdBi+DZ3kG6IEwsQplDnLZevkOgrd5oL6S1i5J5VmcAuSevVDyKFkwgxftYyMdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767127907; c=relaxed/simple;
	bh=AovJp8mhhM9LkK7aOz62lDEWN0PHtpmBRIIZH11UO+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncyIsCkkoKyI4Q+KpnZrqBOnBaIoCEAo5txRjqV0CktCzOM3tO61vWZmVQiqlXiNQnGvf7KqfMqDyO1fgXQ9PCn+7lAhx+6Q/tq5NFQwsKBDgcvwAmD8G5AdssZTuTcojliIleZDCOzsrl4FV3ZjUxH1Js2K6rxKaHl/4TcKUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DjLjN4Lh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LYV0wr0w15SHChxlTYhGXZJaFt5zZ5x2zyP4i+7jSTM=; b=DjLjN4Lh2e7QhxY6Scy+xxes/8
	61PoCx1nXnUXVJomvyzkK1LS8vB4YklbjjRn0LEGAbJqAdoWgllDJbi+6xTIoqsrwV3yCdOtoJVY4
	hzHmEKmobxE5/zphTyna/Nyp+aT0k7Wi8URiOg5uZeurZcV631dmyy5HmESkJu7JmSBmrpkQruYIw
	VFThfIzW/sIA2jMKV++ntrpNr9OEe72/3aDz4nNC4a56WaOmRMbU4FzeM9UWo8abBm1NzrDNVuoSc
	r4Fwlq+bE/Jy7tRK0HOPQksOla6slgLgira/Cv4wyvhuAaRHctNXnVXKXgKx/ayymPzt/qXuVAn1a
	mwgI2MpA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vagga-00000003Og9-0Cod;
	Tue, 30 Dec 2025 20:51:20 +0000
Date: Tue, 30 Dec 2025 20:51:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
	mhocko@suse.com, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <aVQ7RwxRaXC5kAG2@casper.infradead.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
 <1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev>
 <87tsx861o5.fsf@linux.dev>
 <c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
 <krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
 <03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
 <slvvzxjhawqb5kkgfe2tll3owxjwtq2qkwd7m3lmpdslss73lo@hkewnkbik3qr>
 <59098b4f-c3bf-4b6c-80fb-604e6e1c755e@meta.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59098b4f-c3bf-4b6c-80fb-604e6e1c755e@meta.com>

On Tue, Dec 30, 2025 at 02:18:51PM -0500, Chris Mason wrote:
> >>>> I just think you should do a preliminary review of the AI ​​review results
> >>>> instead of sending them out directly. Otherwise, if everyone does this,
> >>>> the community will be full of bots.
> 
> I do think it's awkward to dump the whole review output for the patch
> series in a single message.  It looks like there's a sudden jump to XML?
> It's better to reply to the individual patches with the comments
> inline, which I think is where Roman is trying to go long term.

I don't know what Roman's trying to do long-term, but his email
that started this thread was so badly written that it was offensive.
Had it been sent to me, I would have responded in the style of Arkell
v Pressdram.

> With BPF, it looks more like this:
> https://lore.kernel.org/bpf/?q=AI+reviewed+your+patch

That's actually useful.

> >>>> 2. Looking at the mm prompt: https://github.com/masoncl/review-prompts/blob/main/mm.md , are you sure the patterns are all right?
> >> 	a. Page/Folio States, Large folios require per-page state tracking for
> >> 		Reference counts. I thought we want to get rid of per page refcount.
> 
> Early in prompt development I hand picked a few hundred patches from
> 6.16 fixing bugs, and I iterated on these adding subsystem knowledge to
> catch the known bugs.  That's where that rule came from, but as you say
> there's a risk this information gets old.  Do we want to get rid of per
> page refcounts or have we done it?  (more on that at the bottom of the
> email).

There is no such thing as a per-page reference count.  Any attempt to
access the page reference count redirects to the folio refcount.  This
has been the case since 2016 (four years before folios existed).  See
commit ddc58f27f9ee.

We do want to git rid of calls to get_page() and put_page() for a
variety of reasons that will be long and painful to write out.

> As an example of how I'd fix the prompt if the per page state tracking
> were causing problems (and if we didn't want to just remove it), I asked
> claude to analyze how it is still used.  The output is below, I'd double
> check things as best I could, shorten into prompt form and send to the
> list for review.
> 
> Per-Page Tracking in Large Folios - Analysis
> =============================================
> 
> Based on analysis of mm/*.c files and commit history, MM-004's claim is
> still partially true - large folios do need per-page tracking for some
> bits, though recent work has significantly reduced this.
> 
> 
> Bits That Still Require Per-Page Tracking
> ------------------------------------------
> 
> 1. PG_hwpoison (include/linux/page-flags.h:118)
> 
>    Defined as PAGEFLAG(HWPoison, hwpoison, PF_ANY), this flag is set on
>    individual pages within a large folio when hardware memory corruption
>    is detected.
> 
>    The folio_test_has_hwpoisoned() flag on the second page indicates at
>    least one subpage is poisoned, but does not identify which one.
> 
>    When splitting a large folio, page_range_has_hwpoisoned() in
>    mm/huge_memory.c:3467 iterates through pages checking PageHWPoison()
>    for each:
> 
>        static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
>        {
>            for (; nr_pages; page++, nr_pages--)
>                if (PageHWPoison(page))
>                    return true;
>            return false;
>        }
> 
>    Used in rmap code (mm/rmap.c:1990, 2070, 2473) to check individual
>    subpages when unmapping or migrating.
> 
> 2. PG_anon_exclusive (include/linux/page-flags.h:146)
> 
>    Per the comment at include/linux/page-flags.h:139-145:
> 
>        "Depending on the way an anonymous folio can be mapped into a page
>        table (e.g., single PMD/PUD/CONT of the head page vs. PTE-mapped
>        THP), PG_anon_exclusive may be set only for the head page or for
>        tail pages of an anonymous folio. For now, we only expect it to be
>        set on tail pages for PTE-mapped THP."
> 
>    Used at mm/rmap.c:1408-1416: when RMAP_EXCLUSIVE flag is set for
>    PTE-level mappings, it iterates through each page:
> 
>        for (i = 0; i < nr_pages; i++)
>            SetPageAnonExclusive(page + i);
> 
>    HugeTLB stores this on head page only (see PageAnonExclusive() at
>    include/linux/page-flags.h:1153-1162), but PTE-mapped THP needs
>    per-page tracking.
> 
> 
> Recent Changes - Per-Page Mapcount Removed
> ------------------------------------------
> 
> Commit 749492229e3bd ("mm: stop maintaining the per-page mapcount of
> large folios") by David Hildenbrand (March 2025) introduced
> CONFIG_NO_PAGE_MAPCOUNT which:
> 
>   - Stops maintaining per-page mapcounts in tail pages of large folios
>   - Tail page mapcount is now always logically 0 (-1 value)
>   - Removed _nr_pages_mapped tracking
> 
> This was a significant simplification, but it does not affect the
> per-page flag tracking described above.
> 
> 
> Flags Stored in Second Page Only (Not Per-Page)
> -----------------------------------------------
> 
> These are stored in the first tail page (FOLIO_SECOND_PAGE) and apply to
> the entire folio, not individual pages:
> 
>   - PG_has_hwpoisoned  - indicates some page in folio is poisoned
>   - PG_large_rmappable - folio is rmappable
>   - PG_partially_mapped - folio is partially mapped
> 
> See PAGE_FLAGS_SECOND definition at include/linux/page-flags.h:1218-1220.
> 
> 
> Conclusion
> ----------
> 
> While per-page mapcount has been eliminated, PG_hwpoison and
> PG_anon_exclusive (for PTE-mapped THP) still require per-page tracking
> in large folios. MM-004's claim remains valid for these specific bits.
> 
> Key source files:
>   - include/linux/page-flags.h (flag definitions and accessors)
>   - mm/huge_memory.c (folio split handling)
>   - mm/rmap.c (reverse mapping with per-page exclusive tracking)

This is pretty good and yet dangerously wrong in some missed nuances.
Which probably summarises the state of the art nicely ;-)

To start with, all flags marked as PF_ANY are set on individual pages
rather than only the folio.  So that's currently:

PAGEFLAG(Private, private, PF_ANY)
PAGEFLAG(HWPoison, hwpoison, PF_ANY)
PAGEFLAG(VmemmapSelfHosted, vmemmap_self_hosted, PF_ANY)
__SETPAGEFLAG(Head, head, PF_ANY)
        return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags.f);

Now, PG_private is a flag we're trying to get rid of -- it should be
identical to (folio->private != NULL), so I haven't made any effort
to convert that from being PF_ANY.  I'm not too unhappy that your chatbot
doesn't talk about PG_private, but a more full answer would include
mention of this.

PG_hwpoison and PG_anon_exclusive will remain per-page state in a
memdesc world, and there's a plan to handle those, so there's no need to
eliminate them.

PG_vmemmap_self_hosted is a very, very internal flag.  It's OK to not
know about it.

PG_head has to remain per-page state for now for obvious reasons ;-)
In a memdesc word, there will be no way to ask if a page is the first
page of an allocation, so this flag will not be needed.

I believe there are some subtleties around PG_hwpoison and hugetlb that
are not fully captured above, but I'm not convinced of my ability to
state definitely what they currently are, so I'll leve that for somebody
else to do.

---

Looking through your prompts, there are definitely some conditions that
could be profitably added.  For example, pages which are mapped into
page tables must be PG_uptodate (we have various assertions in the MM
code that this is true and they occasionally trigger).

