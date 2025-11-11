Return-Path: <cgroups+bounces-11778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB5FC4B44B
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87B9D4EF015
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEAB18DB01;
	Tue, 11 Nov 2025 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="noQmNNpG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D75A20D4FC
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830045; cv=none; b=nIG87uhy8qRvoOzVQBeWwea8cjA0aRmB0sY/0nlTGqs2i8600VM9rVFKuuKx6mPl7dujkFdDotnI7K9Lt89WTtH/mI7CklkSF4gt3DxEEeMNjaSg8GiOW3p36POYWeBLFOG4DOPySKvqrcgODX/L4380VtSlSrtreHohNKDAur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830045; c=relaxed/simple;
	bh=WaZ1quIzwngQ3WO6HkRzjGQCMLWlWIqFdIjof6f0ajI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS9dUjq8lnsw6SpoShN/MSV9ldllLHkvDZfzB3JG2edR1PSWG2M3SAp1wf/lBEQebMtBsLQIL1UeOQmTKBxwD6iH1lneQa04yY+Vf8tVCSuyZ2vN88pgVzq8k3kSk+V0ExbIZkK5faIVLC2JsZwlqX7oevasWDhnPK4DUae8p70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=noQmNNpG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 19:00:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762830030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ul2ZY2G57orZgmpduBInIrETuK3NAIisOONEv3fwlE=;
	b=noQmNNpGXqeh55EPq5nX35rk2qS9h7N8CFJCxC2xW5/EEMWN4cxmYtu8eeQTlF2OVaBq4J
	aEiHGJ0In+usILEcVeIIEtQdJSVH5joV422aeigrCaAVnKZco27cq/idJjdw5XR9IOoC6+
	piVfwn4nRzlTsjOEEtTJ92jiQJQcTUM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <hgf4uciz7rp2mpxalcuingafs5ktmsgvom2pefjv3yogel5dh3@7kkwtrnqotnc>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo>
 <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
 <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
 <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 10:48:18AM +0800, Qi Zheng wrote:
> Hi Shakeel,
> 
> On 11/11/25 10:39 AM, Shakeel Butt wrote:
> > On Tue, Nov 11, 2025 at 10:23:15AM +0800, Qi Zheng wrote:
> > > Hi,
> > > 
> > [...]
> > > > 
> > > > Are you or Qi planning a follow-up that converts spin_lock_irq() to
> > > > spin_lock() in places where they disabled IRQs was just to update vmstat?
> > > 
> > > Perhaps this change could be implemented together in [PATCH 1/4]?
> > > 
> > > Of course, it's also reasonable to make it a separate patch. If we
> > > choose this method, I’m fine with either me or Shakeel doing it.
> > > 
> > 
> > Let's do it separately as I wanted to keep the memcg related changes
> > self-contained.
> 
> OK.
> 
> > 
> > Qi, can you please take a stab at that?
> 
> Sure, I will do it.
> 
> > 
> > > > 
> > > > Qi's zombie memcg series will depends on that work I guess..
> > > 
> > > Yes, and there are other places that also need to be converted, such as
> > > __folio_migrate_mapping().
> > 
> > I see __mod_zone_page_state() usage in __folio_migrate_mapping() and
> > using the same reasoning we can convert it to use mod_zone_page_state().
> > Where else do you need to do these conversions (other than
> > __folio_migrate_mapping)?
> 
> I mean converting these places to use spin_lock() instead of
> spin_lock_irq().

For only stats, right?

