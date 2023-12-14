Return-Path: <cgroups+bounces-954-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E74488124B4
	for <lists+cgroups@lfdr.de>; Thu, 14 Dec 2023 02:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EEB1F2186D
	for <lists+cgroups@lfdr.de>; Thu, 14 Dec 2023 01:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E5365B;
	Thu, 14 Dec 2023 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lOa+ybgT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA14D5
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 17:46:29 -0800 (PST)
Date: Wed, 13 Dec 2023 17:46:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702518387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iadDOZ7uuah36iqkq6OTgveCGZQqV5YcB5cpZRi30I0=;
	b=lOa+ybgTpb+IhZ18G8/ofVgOlfldaF1OrOPmKFWFcJsnwgDqdnW3cZB3KEbJ8tjJXSEJ2J
	LpS2N5kjZqU51N3WNzXhqWYXynBb2zQ+9s8dB76Y+nsiMk4LRnW2Mut4+BitJIHpnG5BZF
	qUx8Dt0/W1spYf5LkumbjuMi59fOF10=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeelb@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: remove direct use of
 __memcg_kmem_uncharge_page
Message-ID: <ZXpebcwyzXZaYMZc@P9FQF9L96D.lan>
References: <ZXnabMOjwASD+RO9@casper.infradead.org>
 <CAJD7tkaUGw9mo88xSiTNhVC6EKkzvaJOh=nOwY6WYcG+skQynQ@mail.gmail.com>
 <ZXnbZlrOmrapIpb4@casper.infradead.org>
 <CAJD7tkbjNZ=16vj4uR3BVeTzaJUR2_PCMs+zF_uT+z+DYpaDZw@mail.gmail.com>
 <20231213202325.2cq3hwpycsvxcote@google.com>
 <ZXoTmwIiBoeLItlg@casper.infradead.org>
 <CALvZod7bGiQvEGjiDcKeFFDhdTkAr18rK+20orLX+vCkK4WUUA@mail.gmail.com>
 <CALvZod5X1E6BrT3ErO4OLn3zK__s9c9YQC+yc0T=Tx-gBD3ADQ@mail.gmail.com>
 <CAJD7tkYGwnbBAen_4P7_gAjxwBKCE6XxcMmmcrqJz27vVXSCMA@mail.gmail.com>
 <CALvZod4ky3tmKaqMW8wVQDOQNotmT+Wgu+HFpGN=uOSkZ6ZA6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod4ky3tmKaqMW8wVQDOQNotmT+Wgu+HFpGN=uOSkZ6ZA6w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 13, 2023 at 02:12:35PM -0800, Shakeel Butt wrote:
> On Wed, Dec 13, 2023 at 2:05 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 12:58 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 12:41 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > On Wed, Dec 13, 2023 at 12:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Wed, Dec 13, 2023 at 08:23:25PM +0000, Shakeel Butt wrote:
> > > > > > On Wed, Dec 13, 2023 at 08:31:00AM -0800, Yosry Ahmed wrote:
> > > > > > > On Wed, Dec 13, 2023 at 8:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote:
> > > > > > > > > I doubt an extra compound_head() will matter in that path, but if you
> > > > > > > > > feel strongly about it that's okay. It's a nice cleanup that's all.
> > > > > > > >
> > > > > > > > i don't even understand why you think it's a nice cleanup.
> > > > > > >
> > > > > > > free_pages_prepare() is directly calling __memcg_kmem_uncharge_page()
> > > > > > > instead of memcg_kmem_uncharge_page(), and open-coding checks that
> > > > > > > already exist in both of them to avoid the unnecessary function call
> > > > > > > if possible. I think this should be the job of
> > > > > > > memcg_kmem_uncharge_page(), but it's currently missing the
> > > > > > > PageMemcgKmem() check (which is in __memcg_kmem_uncharge_page()).
> > > > > > >
> > > > > > > So I think moving that check to the wrapper allows
> > > > > > > free_pages_prepare() to call memcg_kmem_uncharge_page() and without
> > > > > > > worrying about those memcg-specific checks.
> > > > > >
> > > > > > There is a (performance) reason these open coded check are present in
> > > > > > page_alloc.c and that is very clear for __memcg_kmem_charge_page() but
> > > > > > not so much for __memcg_kmem_uncharge_page(). So, for uncharge path,
> > > > > > this seems ok. Now to resolve Willy's concern for the fork() path, I
> > > > > > think we can open code the checks there.
> > > > > >
> > > > > > Willy, any concern with that approach?
> > > > >
> > > > > The justification for this change is insufficient.  Or really any change
> > > > > in this area.  It's fine the way it is.  "The check is done twice" is
> > > > > really weak, when the check is so cheap (much cheaper than calling
> > > > > compound_head!)
> > > >
> > > > I think that is what Yosry is trying i.e. reducing two calls to
> > > > page_folio() to one in the page free path.
> > >
> > > Actually no, there will still be two calls to page_folio() even after
> > > Yosry's change. One for PageMemcgKmem() and second in
> > > __memcg_kmem_uncharge_page().
> > >
> > > I think I agree with Willy that this patch is actually adding one more
> > > page_folio() call to the fork code path.
> >
> > It is adding one more page_folio(), yes, but to the process exit path.
> >
> > >
> > > Maybe we just need to remove PageMemcgKmem() check in the
> > > free_pages_prepare() and that's all.
> >
> > You mean call memcg_kmem_charge_page() directly in
> > free_pages_prepare() without the PageMemcgKmem()? I think we can do
> > that. My understanding is that this is not the case today because we
> > want to avoid the function call if !PageMemcgKmem(). Do you believe
> > the cost of the function call is negligible?
> 
> The compiler can potentially inline that function but on the other
> hand we will do twice reads of page->compound_head due to READ_ONCE().
> 
> We don't have data to support one option or the other. Unless we can
> show perf difference between the two, I think doing nothing (leave it
> as is) will be the better use of our time.

+1, especially given how controversial the change is.


