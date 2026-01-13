Return-Path: <cgroups+bounces-13135-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D11D3D170BE
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 08:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6899C308274C
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0E313554;
	Tue, 13 Jan 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdmXy+QH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066E310636
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289773; cv=none; b=XMImiWM0UFBvPQ+SXTIVqIUBx4OV9ETAuCbmK1s/ZE9+cY2XlbLgnzYdOxq6TMZxc36+kiXykKnxc2CZ4L5c+UMf/fQvKNQF0UkvG9DMxS4ekGB2s20hiLGcQW92FkEISQjIem+v1MWm5XiPNK4eDu4cUy280IEhtQPg2d9EBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289773; c=relaxed/simple;
	bh=cD1gmgCMZ2kKsY2iSVlykludi8YdzF4sn4ccaRGgEW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uerYVx48u+aaK2XhCXmn02Pv/2lZ+8JCBLDLzfEkNYk/WARQ9HIV0a1HqeSsa+8L/2e2XdmkQU8KmuVxOVKKc4XdtJ0K99wR2yT7lj3CbRyFVWghlgP+sxwKC/yYsptJ8x7TWzarrfdWgFq2lZN+qr6lFSOW/Yu6S6/6aluCTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdmXy+QH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbc3056afso4127674f8f.2
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 23:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768289768; x=1768894568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUozRbnze9HzpC21A9V0Ws1+iVaj/6k577CuB99o4e0=;
        b=UdmXy+QH1e7OlgjAv0ItCRvAhfpk/BnC/RF0654E178f8y7MRUcqRjMrMbQDbQsChl
         gY6zgtrt4LxDIFNayujDCxK6jRBVI2GpeDYR7zX/+wIQP696UzGixV5CDw8t29BLwJBc
         DeIFIzNahafIJTVBkD/bG/m2CPQcb6mdNDZJFa5ZcWpcX60sIStT+LVPRR7vfKN/SpxQ
         3pVe34VFK8UPEmcrqQRmxdvTwyXDUYfRHHebRP6vVznYtPfGHodb28Umde+9uo4lz79B
         tkvSCVT7Sk7W2W/y9zlOG7+W1k1ostJMvD914ArhWNfLAOEk8Ya9+p7SrAjninG59J/6
         jyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768289768; x=1768894568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUozRbnze9HzpC21A9V0Ws1+iVaj/6k577CuB99o4e0=;
        b=GyT3ExXwJgnCqkEn70w83mxtYEUcp7MWV6+lsTWPEPtVN2m59OZ9O8VpXRr6eblR9N
         K/gKWhj6EJihv2CuGOsiV8L41IDo2VpDnajnsmZeKo1gMQULDYQCzitmSxR/7mZAoEWe
         J6QUqpHTaW3hj/V7CnqxG/Xws1xGv8PPjaTPPiaDkNS6lD4RL3IG54Iw98g/dqf+CJeM
         aOOh5hRTDBjKLyueIMQNoMirPMkV2+HzYEdM6D4rmapd//T6zGH4w8Du5ptVxJ3uWRsn
         aam64op2TyWxTzZ1dEL2vYgkiFK6Lql0uy+Khf4HkvkNwmqa077XcUAaiTO+Mx/DM4aa
         UjWw==
X-Forwarded-Encrypted: i=1; AJvYcCVQVdv4sgMlGDTGhjv4+NNUa/8UfwgSAbZHSPDRhlvPYGxwc2UdvHeCujlBV1fj2Wh40hkDcU1F@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+eIRPS3o+M/nSqroskh8/im02QwSyPeIQ3dvLRMT6mfUYhH0
	GjH6cPYJiw2xKziDry6yVrmZEuviZvZjSaS+9vyMbMNU0EAZgptJ8ToUMtyEnaFpyMKTE/i52kW
	OwBIlHSwraEv/Z7OLW/+l3AvgssGHHiQ=
X-Gm-Gg: AY/fxX54j8UTuWd6fWsgO+4RwIQmvMC4zDHMgZTX4lNXbBB8f+6iSLrQ3cX/LTgmSbJ
	45iXbvbjSFxqgnaEK3eYjoSp/ukK3XsQsHEgWhBk4CzsyPMNR3k/jFirv821/5wycFsaBJqrp6F
	kBMAxw53Av4DwI9Al+yVfA/HIc02/cw/tYLfcRnPUwgUr/nvSFsNR37BPC8RNzUytsTU8Sw/nS0
	l7RlXnilXhr49IPh7GU8alTzUrNA+e64ehmN85qCwZVxZuDTDfUgelPmoPTL3yKMCFE2q8=
X-Google-Smtp-Source: AGHT+IH9RAgZVfoszvmI2rHlHQQ/65rwZdAI+w8Ko1vSjYRWtReTjlaib+Hvfplj6jXWv7FNxUvUF0QpMOELK4Wju5M=
X-Received: by 2002:a05:6000:4301:b0:42b:5592:ebe6 with SMTP id
 ffacd0b85a97d-432c32f701cmr20640766f8f.0.1768289767408; Mon, 12 Jan 2026
 23:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108203755.1163107-1-gourry@gourry.net> <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F> <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
In-Reply-To: <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 13 Jan 2026 16:35:55 +0900
X-Gm-Features: AZwV_QhbH32JBJthS6KlFQhKn8wWXAfJ1iISfNLvWOTOVFurrrg7BnRers1QG9U
Message-ID: <CAKEwX=MftJXOE8H=m1C=_RVL8cu516efixTwcaQMBB9pdj=K+g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net, 
	jonathan.cameron@huawei.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, ziy@nvidia.com, david@kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, rientjes@google.com, 
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	osalvador@suse.de, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, cl@gentwo.org, harry.yoo@oracle.com, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 6:13=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Fri, Jan 09, 2026 at 04:40:08PM -0500, Gregory Price wrote:
> > On Fri, Jan 09, 2026 at 04:00:00PM +0000, Yosry Ahmed wrote:
> > > On Thu, Jan 08, 2026 at 03:37:54PM -0500, Gregory Price wrote:
> > >
> > > If the memory is byte-addressable, using it as a second tier makes it
> > > directly accessible without page faults, so the access latency is muc=
h
> > > better than a swapped out page in zswap.
> > >
> > > Are there some HW limitations that allow a node to be used as a backe=
nd
> > > for zswap but not a second tier?
> > >
> >
> > Coming back around - presumably any compressed node capable of hosting =
a
> > proper tier would be compatible with zswap, but you might have hardware
> > which is sufficiently slow(er than dram, faster than storage) that usin=
g
> > it as a proper tier may be less efficient than incurring faults.
> >
> > The standard I've been using is 500ns+ cacheline fetches, but this is
> > somewhat arbitrary.  Even 500ns might be better than accessing multi-us
> > storage, but then when you add compression you might hit 600ns-1us.
> >
> > This is besides the point, and apologies for the wall of text below,
> > feel free to skip this next section - writing out what hardware-specifi=
c
> > details I can share for the sake of completeness.
>
> The wall of text is very helpful :)
>
> >
> >
> > Some hardware details
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The way every proposed piece of compressed memory hardware I have seen
> > would operate is essentially by lying about its capacity to the
> > operating system - and then providing mechanisms to determine when the
> > compression ratio becomes is dropping to dangerous levels.
> >
> > Hardware Says : 8GB
> > Hardware Has  : 1GB
> > Node Capacity : 8GB
> >
> > The capacity numbers are static.  Even with hotplug, they must be
> > considered static - because the runtime compression ratio can change.
> >
> > If the device fails to achieve a 4:1 compression ratio, and real usage
> > starts to exceed real capacity - the system will fail.
> > (dropped writes, poisons, machine checks, etc).
> >
> > We can mitigate this with strong write-controls and querying the device
> > for compression ratio data prior to actually migrating a page.
>
> I am a little bit confused about this. Why do we only need to query the
> device before migrating the page?
>
> Are we checking if the device has enough memory for the worst case
> scenario (i.e. PAGE_SIZE)?
>
> Or are we checking if the device can compress this specific page and
> checking if it can compress it and store it? This seems like it could be
> racy and there might be some throwaway work.
>
> I guess my question is: why not just give the page to the device and get
> either: successfully compressed and stored OR failed?
>
> Another question, can the device or driver be configured such that we
> reject pages that compress poorly to avoid wasting memory and BW on the
> device for little savings?
>
> >
> > Why Zswap to start
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ZSwap is an existing, clean read and write control path control.
> >    - We fault on all accesses.
> >    - It otherwise uses system memory under the hood (kmalloc)
> >
> > I decided to use zswap as a proving ground for the concept.  While the
> > design in this patch is simplistic (and as you suggest below, can
> > clearly be improved), it demonstrates the entire concept:
> >
> > on demotion:
> > - allocate a page from private memory
> > - ask the driver if it's safe to use
> > - if safe -> migrate
> >   if unsafe -> fallback
> >
> > on memory access:
> > - "promote" to a real page
> > - inform the driver the page has been released (zero or discard)
> >
> > As you point out, the real value in byte-accessible memory is leaving
> > the memory mapped, the only difference on cram.c and zswap.c in the
> > above pattern would be:
> >
> > on demotion:
> > - allocate a page from private memory
> > - ask the driver if it's safe to use
> > - if safe -> migrate and remap the page as RO in page tables
> >   if unsafe
> >      -> trigger reclaim on cram node
> >      -> fallback to another demotion
> >
> > on *write* access:
> > - promote to real page
> > - clean up the compressed page
>
> This makes sense. I am assuming the main benefit of zswap.c over cram.c
> in this scenario is limiting read accesses as well.
>
> [..]
> > > So the CXL code tells zswap what nodes are usable, then zswap tries
> > > getting a page from these nodes and checking them using APIs provided=
 by
> > > the CXL code.
> > >
> > > Wouldn't it be a better abstraction if the nodemask lived in the CXL
> > > code and an API was exposed to zswap just to allocate a page to copy =
to?
> > > Or we can abstract the copy as well and provide an API that directly
> > > tries to copy the page to the compressible node.
> > >
> > > IOW move zswap_compress_direct() (probably under a different name?) a=
nd
> > > zswap_direct_nodes into CXL code since it's not really zswap logic.
> > >
> > > Also, I am not sure if the zswap_compress_direct() call and check wou=
ld
> > > introduce any latency, since almost all existing callers will pay for=
 it
> > > without benefiting.
> > >
> > > If we move the function into CXL code, we could probably have an inli=
ne
> > > wrapper in a header with a static key guarding it to make there is no
> > > overhead for existing users.
> > >
> >
> >
> > CXL is also the wrong place to put it - cxl is just one potential
> > source of such a node.  We'd want that abstracted...
> >
> > So this looks like a good use of memor-tiers.c - do dispatch there and
> > have it set static branches for various features on node registration.
> >
> > struct page* mt_migrate_page_to(NODE_TYPE, src, &size);
> > -> on success return dst page and the size of the page on hardware
> >    (target_size would address your accounting notes below)
> >
> > Then have the migrate function in mt do all the node_private callbacks.
> >
> > So that would limit the zswap internal change to
> >
> > if (zswap_node_check()) { /* static branch check */
> >     cpage =3D mt_migrate_page_to(NODE_PRIVATE_ZSWAP, src, &size);
> >     if (compressed_page) {
> >         entry->page_handle =3D cpage;
> >         entry->length =3D size;
> >         entry->direct =3D true;
> >       return true;
> >     }
> > }
> > /* Fallthrough */
>
> Yeah I didn't necessarily mean CXL code, but whatever layer is
> responsible for keeping track of which nodes can be used for what.
>
> >
> > ack. this is all great, thank you.
> >
> > ... snip ...
> > > > entry->length =3D size
> > >
> > > I don't think this works. Setting entry->length =3D PAGE_SIZE will ca=
use a
> > > few problems, off the top of my head:
> > >
> > > 1. An entire page of memory will be charged to the memcg, so swapping
> > > out the page won't reduce the memcg usage, which will cause thrashing
> > > (reclaim with no progress when hitting the limit).
> > >
> > > Ideally we'd get the compressed length from HW and record it here to
> > > charge it appropriately, but I am not sure how we actually want to
> > > charge memory on a compressed node. Do we charge the compressed size =
as
> > > normal memory? Does it need separate charging and a separate limit?
> > >
> > > There are design discussions to be had before we commit to something.
> >
> > I have a feeling tracking individual page usage would be way too
> > granular / inefficient, but I will consult with some folks on whether
> > this can be quieried.  If so, we can add way to get that info.
> >
> > node_private_page_size(page) -> returns device reported page size.
> >
> > or work it directly into the migrate() call like above
> >
> > --- assuming there isn't a way and we have to deal with fuzzy math ---
> >
> > The goal should definitely be to leave the charging statistics the same
> > from the perspective of services - i.e zswap should charge a whole page=
,
> > because according to the OS it just used a whole page.
> >
> > What this would mean is memcg would have to work with fuzzy data.
> > If 1GB is charged and the compression ratio is 4:1, reclaim should
> > operate (by way of callback) like it has used 256MB.
> >
> > I think this is the best you can do without tracking individual pages.
>
> This part needs more thought. Zswap cannot charge a full page because
> then from the memcg perspective reclaim is not making any progress.
> OTOH, as you mention, from the system perspective we just consumed a
> full page, so not charging that would be inconsistent.
>
> This is not a zswap-specific thing though, even with cram.c we have to
> figure out how to charge memory on the compressed node to the memcg.
> It's perhaps not as much of a problem as with zswap because we are not
> dealing with reclaim not making progress.
>
> Maybe the memcg limits need to be "enlightened" about different tiers?
> We did have such discussions in the past outside the context of
> compressed memory, for memory tiering in general.

What if we add a reclaim flag that says "hey, we are hitting actual
memory limit and need to make memory reclaim forward progress".

Then, we can have zswap skip compressed cxl backend and fall back to
real compression.

(Maybe also demotion, which only move memory from one node to another,
as well as the new cram.c stuff? This will technically also save some
wasted work, as in the status quo we will need to do a demotion pass
first, before having to reclaiom memory from the bottom tier anyway?
But not sure if we want this).

>
> Not sure if this is the right place to discuss this, but I see the memcg
> folks CC'd so maybe it is :)
>
> >
> > >
> > > 2. The page will be incorrectly counted in
> > > zswap_stored_incompressible_pages.
> > >
> >
> > If we can track individual page size, then we can fix that.
> >
> > If we can't, then we'd need zswap_stored_direct_pages and to do the
> > accounting a bit differently.  Probably want direct_pages accounting
> > anyway, so i might just add that.
>
> Yeah probably the easiest way to deal with this, assuming we keep
> entry->length as PAGE_SIZE.

Yeah this one is no big deal. I like a new informative counter :)

>
> >
> > > Aside from that, zswap_total_pages() will be wrong now, as it gets th=
e
> > > pool size from zsmalloc and these pages are not allocated from zsmall=
oc.
> > > This is used when checking the pool limits and is exposed in stats.
> > >
> >
> > This is ignorance of zswap on my part, and yeah good point.  Will look
> > into this accounting a little more.
>
> This is similar-ish to the memcg charging problem, how do we count the
> compressed memory usage toward the global zswap limit? Do we keep this
> limit for the top-tier? If not, do we charge full size for pages in
> c.zswap or compressed size?
>
> Do we need a separate limit for c.zswap? Probably not if the whole node
> is dedicated for zswap usage.
>
> >
> > > > +         memcpy_folio(folio, 0, zfolio, 0, PAGE_SIZE);
> > >
> > > Why are we using memcpy_folio() here but copy_mc_highpage() on the
> > > compression path? Are they equivalent?
> > >
> >
> > both are in include/linux/highmem.h
> >
> > I was avoiding page->folio conversions in the compression path because
> > I had a struct page already.
> >
> > tl;dr: I'm still looking for the "right" way to do this.  I originally
> > had a "HACK:" tag here previously but seems I definitely dropped it
> > prematurely.
>
> Not a big deal. An RFC or HACK or whatever tag just usually helps signal
> to everyone (and more importantly, to Andrew) that this should not be
> merged as-is.
>
> >
> > (I also think this code can be pushed into mt_ or callbacks)
>
> Agreed.
>
> >
> > > > + if (entry->direct) {
> > > > +         struct page *freepage =3D (struct page *)entry->handle;
> > > > +
> > > > +         node_private_freed(freepage);
> > > > +         __free_page(freepage);
> > > > + } else
> > > > +         zs_free(pool->zs_pool, entry->handle);
> > >
> > > This code is repeated in zswap_entry_free(), we should probably wrap =
it
> > > in a helper that frees the private page or the zsmalloc entry based o=
n
> > > entry->direct.
> > >
> >
> > ack.
> >
> > Thank you again for taking a look, this has been enlightening.  Good
> > takeaways for the rest of the N_PRIVATE design.
>
> Thanks for kicking off the discussion here, an interesting problem to
> solve for sure :)
>
> >
> > I think we can minimize zswap changes even further given this.
> >
> > ~Gregory

