Return-Path: <cgroups+bounces-13848-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GOuGNy4i2kUZwAAu9opvQ
	(envelope-from <cgroups+bounces-13848-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 00:01:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBAA11FDEB
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 00:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34911301DAF1
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 23:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61535313E2B;
	Tue, 10 Feb 2026 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Ar0fgB/I"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324B313273
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770764493; cv=none; b=j6LiJMt80EelUvXhS3TkS1r8/TUUwbbe/PUWJoNtC29zkLcnfkZokccxjzbMx1DVUcEnx6K33DtwW1PUsv1J3NzROOlKy5Qn46Cn4i2VGmNi7sr4pBHn2Llr95O033nbW+9M4VWBAoyrW4PTr2jdWollZODhJOtQToXtgf/967o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770764493; c=relaxed/simple;
	bh=WBNao4ryE+swbKfD5O/WStYC6DQIH/DzJ3IpuJIgAik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf0xk8OJ3Ls5f/dLeiEh+3o7iGBQ6qDAmBHfXmFjXzx+SNDUrlU4ytgyt9UYN4DXNbBAn/CBJDcf/eAuLP1MhPbTBJp57P/FDc5de0S+wONCt5qA1Q8IFNIKAGR7zDDBmH7uyNbfDVyGBiKMf0eQ7vZuH+GN+172HnfGCaJtRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Ar0fgB/I; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89503a3bb83so11768456d6.1
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1770764490; x=1771369290; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+gdZ7g+y11yA/yc1S8C5vrwqug7WtAPc1WlCmDFfWbg=;
        b=Ar0fgB/IuMNM3J5GpIsrq3Rh9mGtk7FuaRBN/3xCctyidKdP06Z1kC/rlNSfB+uzYd
         +TXSVwjlILAqLEfPePcTw7jsO63eIR3NUrifeCKMxbcqad8lA678kyNEWuht/09YEwE5
         1z2tW1HIEpFIDM3L2Rw8EdDAsCcFl7pQX2iS/IG5N9LnOndx/zGUdBqXa3Kw4TANFekN
         /qmIfu4JgFtFpN0KcbP9vC3soriACtAa4wRUais3FhaGMvUF/+2TkUbUoL/aeN2pXN32
         SRZnKLVG7OzBukHB7StphYh/EqOlG8VTTertk2eKxXpbe9Yt+OiysZKahcTvBjTlhulh
         CNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770764490; x=1771369290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gdZ7g+y11yA/yc1S8C5vrwqug7WtAPc1WlCmDFfWbg=;
        b=f2Kp7HU+5XouRNEhj25x4g46QhJDaPbgblQ+z+2kxMYiZaSX5AsS5cnKa1OiQagW5G
         HwSpqWHdSKeBEfUtD+y13Y5AkH5y1hXbxUKhUyhyloh0BphAijA+hmEGAj62Aag+Qki6
         KPr2TLbpP0AoB3pdXc7JHtJ1gPLvQ25HHr2ZtDWwqu0Zbn39Ly0Jb9pQJonwzfB1gyep
         4mxSk6eqouHmS+ngtAZnoswLzCquDQgvbX/RjnL61jrQ6VVGT80vRDzcqIrQvepd4/3N
         KujsRUBbtl6WuoMyZfWqzBZ1fxWaC4PY3unV5nvSTR7tcskauB2iff5wwSboRwg+ARcn
         eGnA==
X-Forwarded-Encrypted: i=1; AJvYcCWz8jDbgzEJSrlUxdqHe/mxiWWMb1saTMnAzNIm/CcHQvhhz7/kOOrssslzqSH6yNDQ8mWkYgPu@vger.kernel.org
X-Gm-Message-State: AOJu0YyJC1IyutJREq963aHyyScHGynjGTTw5RMh9b+2zrJap+MzgF5b
	le7Za30Fb63y5OEwM2dbPWL1l+KXwFpHpMyaI1JCSx7cQws5FY7eDEjBf32Zv8UUo5A=
X-Gm-Gg: AZuq6aJr9ykiOZaQpUVYFcpCU8uOM4lMI6vYlCT1zkBNPlpItl9CP5IedJabmyGfds4
	i+sMqYTvICM+rBwzNwwtaloVodwEg8FxfFipPV70967wK0yCRv9k3B80+oNoTv0EBH5K/i/4cTA
	VHht67sJ1VL9Ygauk6p6nMCRNeZuuftAtRU3WZggMHd3lXgestrtlcbB+0tib+gx1UmIcZ6f6Qf
	hmv+7yg7kygplrc9cV9NFOOp9Wt5LNF3F3DCtiMkRnLBG6Kfb7Gcj5ojXTo1tzQUYMhYgzx3tC/
	cm9ZodU8BL8cBETex2HJyeRobtdF5yIFJlSfC8PD32Z5OUr4Zb5lsLJ1DzOs3gRIL1MWUQ97F5v
	0r3DKSfGKgl3mRMEYYGkWsveRW2iraIOKZJfk7XDdeT52LhzzJR2zBrERUzLDctScfrdP78An1l
	hdlKVwmn2x1enQRWiHsFf5CRgigzf/yvY=
X-Received: by 2002:a05:6214:762:b0:896:fbdd:ef02 with SMTP id 6a1803df08f44-896fbddfd6bmr128746116d6.3.1770764489838;
        Tue, 10 Feb 2026 15:01:29 -0800 (PST)
Received: from localhost ([2603:7000:c00:100:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f2a5sm600336d6.11.2026.02.10.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 15:01:29 -0800 (PST)
Date: Tue, 10 Feb 2026 18:01:24 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chris Li <chrisl@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk,
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de,
	christophe.leroy@csgroup.eu, pavel@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-pm@vger.kernel.org,
	peterx@redhat.com, riel@surriel.com, joshua.hahnjy@gmail.com,
	npache@redhat.com, gourry@gourry.net, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, rafael@kernel.org,
	jannh@google.com, pfalcato@suse.de, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
Message-ID: <aYu4xK8HhjO7mLP8@cmpxchg.org>
References: <20260208215839.87595-2-nphamcs@gmail.com>
 <20260208223143.366416-1-nphamcs@gmail.com>
 <CACePvbXsngZmn0OrJZjvMhhHnL5FazxYX7ShEpbU9RwHSJaUuA@mail.gmail.com>
 <aYqZppn4yDbTP2_q@cmpxchg.org>
 <CACePvbWnJFkMOtX8LbL+0hm5RP6jD5nfZcYUyxrJsPNTq0vbPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbWnJFkMOtX8LbL+0hm5RP6jD5nfZcYUyxrJsPNTq0vbPg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13848-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,kvack.org,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEBAA11FDEB
X-Rspamd-Action: no action

Hi Chris,

On Tue, Feb 10, 2026 at 01:24:03PM -0800, Chris Li wrote:
> Hi Johannes,
> On Mon, Feb 9, 2026 at 6:36 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Here is the more detailed breakdown:
> 
> It seems you did not finish your sentence before sending your reply.

I did. I trimmed the quote of Nhat's cover letter to the parts
addressing your questions. If you use gmail, click the three dots:

> > > > The size of the virtual swap descriptor is 24 bytes. Note that this is
> > > > not all "new" overhead, as the swap descriptor will replace:
> > > > * the swap_cgroup arrays (one per swap type) in the old design, which
> > > >   is a massive source of static memory overhead. With the new design,
> > > >   it is only allocated for used clusters.
> > > > * the swap tables, which holds the swap cache and workingset shadows.
> > > > * the zeromap bitmap, which is a bitmap of physical swap slots to
> > > >   indicate whether the swapped out page is zero-filled or not.
> > > > * huge chunk of the swap_map. The swap_map is now replaced by 2 bitmaps,
> > > >   one for allocated slots, and one for bad slots, representing 3 possible
> > > >   states of a slot on the swapfile: allocated, free, and bad.
> > > > * the zswap tree.
> > > >
> > > > So, in terms of additional memory overhead:
> > > > * For zswap entries, the added memory overhead is rather minimal. The
> > > >   new indirection pointer neatly replaces the existing zswap tree.
> > > >   We really only incur less than one word of overhead for swap count
> > > >   blow up (since we no longer use swap continuation) and the swap type.
> > > > * For physical swap entries, the new design will impose fewer than 3 words
> > > >   memory overhead. However, as noted above this overhead is only for
> > > >   actively used swap entries, whereas in the current design the overhead is
> > > >   static (including the swap cgroup array for example).
> > > >
> > > >   The primary victim of this overhead will be zram users. However, as
> > > >   zswap now no longer takes up disk space, zram users can consider
> > > >   switching to zswap (which, as a bonus, has a lot of useful features
> > > >   out of the box, such as cgroup tracking, dynamic zswap pool sizing,
> > > >   LRU-ordering writeback, etc.).
> > > >
> > > > For a more concrete example, suppose we have a 32 GB swapfile (i.e.
> > > > 8,388,608 swap entries), and we use zswap.
> > > >
> > > > 0% usage, or 0 entries: 0.00 MB
> > > > * Old design total overhead: 25.00 MB
> > > > * Vswap total overhead: 0.00 MB
> > > >
> > > > 25% usage, or 2,097,152 entries:
> > > > * Old design total overhead: 57.00 MB
> > > > * Vswap total overhead: 48.25 MB
> > > >
> > > > 50% usage, or 4,194,304 entries:
> > > > * Old design total overhead: 89.00 MB
> > > > * Vswap total overhead: 96.50 MB
> > > >
> > > > 75% usage, or 6,291,456 entries:
> > > > * Old design total overhead: 121.00 MB
> > > > * Vswap total overhead: 144.75 MB
> > > >
> > > > 100% usage, or 8,388,608 entries:
> > > > * Old design total overhead: 153.00 MB
> > > > * Vswap total overhead: 193.00 MB
> > > >
> > > > So even in the worst case scenario for virtual swap, i.e when we
> > > > somehow have an oracle to correctly size the swapfile for zswap
> > > > pool to 32 GB, the added overhead is only 40 MB, which is a mere
> > > > 0.12% of the total swapfile :)
> > > >
> > > > In practice, the overhead will be closer to the 50-75% usage case, as
> > > > systems tend to leave swap headroom for pathological events or sudden
> > > > spikes in memory requirements. The added overhead in these cases are
> > > > practically neglible. And in deployments where swapfiles for zswap
> > > > are previously sparsely used, switching over to virtual swap will
> > > > actually reduce memory overhead.
> > > >
> > > > Doing the same math for the disk swap, which is the worst case for
> > > > virtual swap in terms of swap backends:
> > > >
> > > > 0% usage, or 0 entries: 0.00 MB
> > > > * Old design total overhead: 25.00 MB
> > > > * Vswap total overhead: 2.00 MB
> > > >
> > > > 25% usage, or 2,097,152 entries:
> > > > * Old design total overhead: 41.00 MB
> > > > * Vswap total overhead: 66.25 MB
> > > >
> > > > 50% usage, or 4,194,304 entries:
> > > > * Old design total overhead: 57.00 MB
> > > > * Vswap total overhead: 130.50 MB
> > > >
> > > > 75% usage, or 6,291,456 entries:
> > > > * Old design total overhead: 73.00 MB
> > > > * Vswap total overhead: 194.75 MB
> > > >
> > > > 100% usage, or 8,388,608 entries:
> > > > * Old design total overhead: 89.00 MB
> > > > * Vswap total overhead: 259.00 MB
> > > >
> > > > The added overhead is 170MB, which is 0.5% of the total swapfile size,
> > > > again in the worst case when we have a sizing oracle.

