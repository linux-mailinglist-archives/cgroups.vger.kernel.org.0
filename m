Return-Path: <cgroups+bounces-13075-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A18D13BD2
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 16:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F4F305965C
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB5B2FD68B;
	Mon, 12 Jan 2026 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="GvNwP+2a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A92F8BCA
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231638; cv=none; b=RJxWk3jyctyF8LUZjpIeKHquMwUSEr3TuDJgZrJwn/T43Dv6FOZ1pOVp9XxB+75cv1NCnL4fcmXlbRbftr+SpQ0EvtWpH41S4JsbzTwn+4508ntiWLK5uZVRAfEdX16PzLCzsxuH9dFr/iFoolEr6uDAn9pAN/1tVPNwL50PLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231638; c=relaxed/simple;
	bh=/KZrNpTOv53Hf6emFKpIDyGwi6CuZM71jTQ4Nu4PF2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgXFggN7dXBX0MyqPWKkPbQ48caku47BN5tauuGsnFcNdXVPzNVwO2TQyW3bDzPykP3CobcbXiXywiVDQq6F1ncdKiLgQZtnKd+kl8eN0j+VseNVpWiNALdvuvU1Id6ePsmCYQpzo7/Kg2uy8zSkV+aedyO4uARlNA7eLdVTzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=GvNwP+2a; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2d32b9777so985444885a.2
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1768231632; x=1768836432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KZrNpTOv53Hf6emFKpIDyGwi6CuZM71jTQ4Nu4PF2M=;
        b=GvNwP+2a1sO1BX/0MILpf88sBLr0zKy7FXnrGi3MPc8yqdSzId6U9YXXVUDpMWg42y
         Kyp8B5+2JV8nVY9hMv/BWTo3TBBCzFZtn9OQGaBpbQefjvY8kgZAHw/Ozl7cpckgaw4U
         QvkVf2f15Ceuew3yY4c4CubQlZo/dBJ7Pf85xoRvhEZVZW8vUywY77gbe6hWqXyJQ3oK
         eUD+jV6WtPxFNsCi2cPrpBidgLyoWeS8OiXdkqilZs12ojqVXFTnU0u68zGypaxx4mMk
         w8X2WYPrS8voElo849lFYTo120+SirepBp9kXwaKtz7fEjVgUdUKhAF80AwRKdUu4yqn
         u/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768231632; x=1768836432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KZrNpTOv53Hf6emFKpIDyGwi6CuZM71jTQ4Nu4PF2M=;
        b=wQlj2IjlhZU/Owg7k3lby6244+RM2HJAnCIF1ScjlSfeAWpaNOGppJTECqAmhKBmNf
         52Wik/z8Kx/QUoL9Bf6wBsZcObytlA8qYtTwG4b+D2TPiCd0ZI8Ng9wJeCd27eFKF1gq
         4TqHGJvJFzbeypQHiw8WOVnyTdSG0tXRdCOWsPkkEMu09CDLjpI0WaEYmA15oNKO6XdJ
         eiC6+kbZccTc05bg0xXV9uPtvWMfwVbEjFoLVuWO0oUIwByDIXPXYY26waRYchWv5ZhF
         iElI3VlRhIX9QABMdEBPMKxOsSg0tv32vQsybp/LNL9UNiJszlrERpvoUaNW8ulOa/V1
         cHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuwxrmPjZoVFrb7C3yu/QXqwhFyELDZiKRI7Jp/an6ASJ6kwrDlgrT7Jv1pqatPuBNEwiU4CWk@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSt3+bG91UMDIgnrXhT1/RNwPmp7k2D/wEl9T5Da3e5k1XTmu
	e6AdKzeC48o3ij2tzP7GgsOswT0AODCBOS6n3KD7i9wGonbIgUJcD/fftBGwC0AqaHY=
X-Gm-Gg: AY/fxX6IiL/RoMEPkc2xQ0z2Neb/vJSeR3kaKtHcQCGu6yzWzdgDDGJDBBuTXUWiTN1
	pdWjtlq9xWUk+9VX0499xNWDN1iTMg++lWst568k7e6DK5Skjw6Mu5ZrYXNm9YUSS2u+UfaJvDn
	5ZhI6iXMkUGPrG7RMbxZfJ+6hhV+1EBlVP5pSJumLTFvTCTgRSilqUpPLVQBP21sTxevEjbBYXP
	0trS1IIjCuibUUMOby1iQd6ZV7cROjM7LuVPquWan5Cr0PT8+Y1nge8kHoFMBs+5pxOGGe75eDk
	fWw0sSakTljnc5LGdAxexLqKEvqKlMRqsSI9m5AXhAozqsM69aQxyV92buewloAjyK/Wr72COz/
	58Dz89Rs3I0qGWzGLl+ESKX36q/48/8bYsZlRTH2M3Z2GfAoZN5pZW5A3v23nkL8lSB+l0+H6ku
	JoD2K2ncSoKDDRbkEAWu73
X-Google-Smtp-Source: AGHT+IEMJiA/1eid9s4j9DWQmqT6T/1kpjdK8HlfZHWC5kbrB6Xvn594oXzyY6TZwshoZ0nf0OGjPg==
X-Received: by 2002:a05:620a:7087:b0:8b2:f182:694e with SMTP id af79cd13be357-8c3893f4e8amr2476371785a.54.1768231632134;
        Mon, 12 Jan 2026 07:27:12 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a97fesm1512326085a.4.2026.01.12.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:27:11 -0800 (PST)
Date: Mon, 12 Jan 2026 10:27:07 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com,
	Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH] mm/swap_cgroup: fix kernel BUG in swap_cgroup_record
Message-ID: <aWUSyzHcaDwEg6_c@cmpxchg.org>
References: <20260110064613.606532-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110064613.606532-1-kartikey406@gmail.com>

On Sat, Jan 10, 2026 at 12:16:13PM +0530, Deepanshu Kartikey wrote:
> When using MADV_PAGEOUT, pages can remain in swapcache with their swap
> entries assigned. If MADV_PAGEOUT is called again on these pages,

This doesn't add up to me - maybe I'm missing something.

memcg1_swapout() is called at the very end of reclaim, from
__remove_mapping(), which *removes the folio from swapcache*. At this
point the folio is exclusive to *that* thread - there are no more
present ptes that another madvise could even be acting on.

How could we reach here twice for the same swap entry?

It seems more likely that we're missing a swapin notification, fail to
clear the swap entry from the cgroup records, and then trip up when
the entry is recycled to a totally different page down the line. No?

