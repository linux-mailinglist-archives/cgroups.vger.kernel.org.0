Return-Path: <cgroups+bounces-12817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9680CE916E
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 09:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03E0E3002B8A
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 08:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D32D9EDC;
	Tue, 30 Dec 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZhetyhhN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE87261593
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767084867; cv=none; b=WyZyTo8LP3Zr1mTPgOFj4IcAx+Xkhl+4ccCY85pahV2ElgXOJU5dmV1/QFORqI3dbUsY/neonEHg0WD0GfdxYAfdR02SjfM4lDn6Cylms5URJxAmEr10Sc0L4WEYJwPcuNolhk6XgKse4CbnTsFBmiViAoM1q3tmOKzWrHB9uIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767084867; c=relaxed/simple;
	bh=2ASJQcPXt2Ym8bgzcMtEZzscEQ++ow0GPYHsRU/8ndY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EplNn+b+pIcAPaYapy6Xb49Yqo6BSaNr9/KCErVEEmzqSTH49XMEsRRwHfP7F830g3oFx4uphMlepSkgpTHypX2WPzr6B9M1115aFfyaIETrMSgvESKOhihVoV9H11/sawosHd94oPRXkYeZp62IAVVRYy75ir6cwSIbDTc9ZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZhetyhhN; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 30 Dec 2025 16:54:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767084853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFQ1B7f3jdUQJv/G4p3v4Or/bwoQHErH3VgRPq8vePw=;
	b=ZhetyhhNbz0ZQJ0nLazfs2RkkKQpHKojBVKfyKa3LJ1f7XmNJ/QA0MBasfWvWo7I/jgFLA
	vudU0RbFjHioUSoDY6EQkExJa6ttuGb/hNtMst9/A4GTs+fq+tQ2Decv8wtaoINpM6nUbu
	+rzG/WQzYg4jHhtRqf0HeQg3tq9AMh8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@gentwo.org, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, 
	surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH V4 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <tyc35ufouc6uskxthnnm37aatzffy3lw3qtguqjsgtkscs4d54@cupdpbhjd64y>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-9-harry.yoo@oracle.com>
 <l2xww4mysued3fjc2jzzy6cjrq5guygsxesmfqrhv2laxigpaq@ghj7xitfq7fh>
 <aUuKgRlI60Hw3-Et@hyeyoo>
 <hofqvftaj7ofgdvzb56hvjgk7chxkb5gfsj3324e7wal72mjll@7m4s7adnk35j>
 <aVNcTVKmz9N6bOfF@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVNcTVKmz9N6bOfF@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 30, 2025 at 01:59:57PM +0900, Harry Yoo wrote:
> On Wed, Dec 24, 2025 at 08:43:17PM +0800, Hao Li wrote:
> > On Wed, Dec 24, 2025 at 03:38:57PM +0900, Harry Yoo wrote:
> > > On Wed, Dec 24, 2025 at 01:33:59PM +0800, Hao Li wrote:
> > > > One more thought: in calculate_sizes() we add some extra padding when
> > > > SLAB_RED_ZONE is enabled:
> > > > 
> > > > if (flags & SLAB_RED_ZONE) {
> > > > 	/*
> > > > 	 * Add some empty padding so that we can catch
> > > > 	 * overwrites from earlier objects rather than let
> > > > 	 * tracking information or the free pointer be
> > > > 	 * corrupted if a user writes before the start
> > > > 	 * of the object.
> > > > 	 */
> > > > 	size += sizeof(void *);
> > > > 	...
> > > > }
> > > > 
> > > > 
> > > > From what I understand, this additional padding ends up being placed
> > > > after the KASAN allocation metadata.
> > > 
> > > Right.
> > > 
> > > > Since it’s only "extra" padding (i.e., it doesn’t seem strictly required
> > > > for the layout), and your patch would reuse this area — together with
> > > > the final padding introduced by `size = ALIGN(size, s->align);`
> > > 
> > > Very good point!
> > > Nah, it wasn't intentional to reuse the extra padding.
> 
> Waaaait, now I'm looking into it again to write V5...
> 
> It may reduce (or remove) the space for the final padding but not the
> mandatory padding because the mandatory padding is already included
> in the size before `aligned_size = ALIGN(size, s->align)`

Ah, right - I double-checked as well. `aligned_size - size` is exactly the
space reserved for the final padding, so slabobj_ext won't eat into the
mandatory padding.

> 
> > > > for objext, it seems like this padding may no longer provide much benefit.
> > > > Do you think it would make sense to remove this extra padding
> > > > altogether?
> > > 
> > > I think when debugging flags are enabled it'd still be useful to have,
> > 
> > Absolutely — I’m with you on this.
> > 
> > After thinking about it again, I agree it’s better to keep it.
> > 
> > Without that mandatory extra word, we could end up with "no trailing
> > padding at all" in cases where ALIGN(size, s->align) doesn’t actually
> > add any bytes.
> > 
> > > I'll try to keep the padding area after obj_ext (so that overwrites from
> > > the previous object won't overwrite the metadata).
> > 
> > Agree — we should make sure there is at least sizeof(void *) of extra
> > space after obj_exts when SLAB_RED_ZONE is enabled, so POISON_INUSE has
> > somewhere to go.
> 
> I think V4 of the patchset is already doing that, no?
> 
> The mandatory padding exists after obj_ext if SLAB_RED_ZONE is enabled
> and the final padding may or may not exist. check_pad_bytes() already knows
> that the padding(s) exist after obj_ext.

Yes, you are right, V4 already does this — I just hadn't noticed it earlier...

> 
> By the way, thanks for fixing the comment once again,
> it's easier to think about the layout now.

Glad it helped. The object layout is really subtle — missing even a
small detail was enough to throw us off. Glad we finally got it all
straightened out.

-- 
Thanks,
Hao

