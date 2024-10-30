Return-Path: <cgroups+bounces-5337-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5A9B6689
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 15:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C21AB224AC
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9051F6698;
	Wed, 30 Oct 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Kh72ghVR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440CC1F131C
	for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299942; cv=none; b=BwHFINWAFBN73IWtSj7b33dJ1zHYx/ii+mkqAQEUOfMNwqyxk8iTMaRhWfGkSiDm2NpmAG8fDx8s+/bhx96Ef8oOFIvD5fYxlw6M2gRWTTmSLCdnnPDd2ijYKizUuCiQULkHRYpCw/NOG+YZcd9r7Wn1pkTfbsg6qU+Pv6gZDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299942; c=relaxed/simple;
	bh=/nTu4yiVBod9F3pqX7RljXeoBuJmAXaC0LVBlRDlCkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR/OpRg019+m/WwvWDDKQ33nE24mLVpfqaQkmYqkVdS2ixXhCGjIWn9A44AhvCgH42M0Cc+AFQUnkDsFlrDJTcYa0kfALBSUqVNe//3ugBJIhN1Kl7HDxUjt0iCs9dAxQIU/uDEyhOunLRFJm2d+U2Cgk/0w78tZtoUKDyaUtsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=Kh72ghVR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315eac969aso6808775e9.1
        for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730299938; x=1730904738; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SSvlJM/OhJQtJUJbC46VqSozyrQEBY8ZBkPG7MvxSU=;
        b=Kh72ghVRwv6AbQYUpvgeinsM/cRUr/Y05PmhrB7H/zoT6ux+f/CROtLZ+LQizV7w/H
         6GDrULyqtR2l02zkpOxgayksZCTTgro7YWsy0RndvIP20l7PfRbEqLO9Ivg0byXsETDZ
         /LYhy97lDTL0FSAg4Ay+UA77NgVGQbguh2SNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730299938; x=1730904738;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SSvlJM/OhJQtJUJbC46VqSozyrQEBY8ZBkPG7MvxSU=;
        b=PDh0f4j6zNp4gKr6FB7HwYXfKD1YMN6gcIScJ3TvGwHNkQHLvjzEwOG6Xd9IKhGSZG
         trH/1yZG9pQnNrqnA4ydkqFDkf2lS34Zsdg8Q+yMAXBofUqO4zG2vx+VHvWZ1RIxelqc
         trij/O2kw63V7vdqkrxveZBtSuP8MGIVkwu0y5Qrxy9drb+Ma8DMozvRCjj6k93lMBqr
         q4VV27y2zDS/QxiHxKpc5UL0MdHWGKOd+seL6PigNQBDYUqo0HfGvTgjCOU3KjMsePKZ
         bbEVSnwpdbBcbj1EpOBUQkP+R8jhfrl8keXK5NLBRDZOrppmimgzdkKKYqTK/N1m2oAw
         zb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYNf7iTWY54l4Fr/TTntecmhDAK+IMgAS0dj7ukwJYWqcb0gSChAonwmJoFA3JTl2Zx61Kseg6@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJjD7jj26NmjtUftbPONxLtsigt05D4Wv2H44+c8gKHnyA8pg
	5ofIPTZy25WYBiTxHpWaSEHzaMcXSQelc6/6KqhW3RcXQf3cBc1oApHAcex/F7jnuxpThtNGTS+
	i6AI=
X-Google-Smtp-Source: AGHT+IEAajtEtz+5vxf3sLgzdnDhCBIDBSA638FA1MLL1J8zLQtfa0+HFp2WolOX0nhmzzXHkrJHBA==
X-Received: by 2002:a05:600c:512a:b0:42c:b98d:b993 with SMTP id 5b1f17b1804b1-431b5704cbemr49907195e9.2.1730299937500;
        Wed, 30 Oct 2024 07:52:17 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c3absm15638414f8f.21.2024.10.30.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:52:17 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:52:16 +0000
From: Chris Down <chris@chrisdown.name>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, shakeel.butt@linux.dev,
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
	tj@kernel.org, lizefan.x@bytedance.com, mkoutny@suse.com,
	corbet@lwn.net, lnyng@meta.com, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <ZyJIIEEWTXKysQLi@chrisdown.name>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Thanks for the detailed changelog, it answered a bunch of questions about the 
general semantics I had.

Joshua Hahn writes:
>Suggested-by: Nhat Pham <nphamcs@gmail.com>
>Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
>Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Acked-by: Chris Down <chris@chrisdown.name>

