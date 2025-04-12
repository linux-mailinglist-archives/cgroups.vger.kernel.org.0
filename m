Return-Path: <cgroups+bounces-7499-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669D7A86DCD
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 16:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC2C8A6A2F
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28F31EB18E;
	Sat, 12 Apr 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JnaOdI5B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D1195FEF
	for <cgroups@vger.kernel.org>; Sat, 12 Apr 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468554; cv=none; b=GCwV4a8kEhewPOprmJ1wWA0tCoKCm57UmrbHjPTAQxJ76PhzooDYowZFSXcwwKLYEyx/9AUe3CYGN08lsMCpNgYYWyO1ZhU8QDgKHug85dB+NQ0Mn63Bvvki+EXAoq+CwyUz8L4PUuP3Y4ggV3nc3J3OquGET7ku/3IJtJfDfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468554; c=relaxed/simple;
	bh=TbaDZzL6rMhmNxwCb5EkKrjkKd4SNnXJvVsLOY0xK3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMQj1+JkLd4CCb87cnLlgvDrZaRMT/KozX8tgETwudqDUF+8ZWK9DF9J6mpf/dCf5DzuCDwn8BaGwO7vqU4IumtVY4/fXhtH2tJK9NKF/ojF5v+8xFQ+vBJCQttnKDzMq134Mq0zeM++1PK0adGgAfS3mdjZmY+i3RDOf2wPWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JnaOdI5B; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e900a7ce55so42944546d6.3
        for <cgroups@vger.kernel.org>; Sat, 12 Apr 2025 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744468551; x=1745073351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKA6CW8lkxsZYkZcNj1adEARS2rUQdUi3RNcgzxuj0E=;
        b=JnaOdI5BUB0a3mlfHxjKSZGw46aH6gXZo3DGj0ORT8gZsbH4o4+TlBxBpt4Rep/EmP
         kwMNPG2u31oIQGPNe0kVnt23tLej+Xy5GzszUn+J+9CBXEvFUwPkngFY91G4aHobku53
         zJIheAqNCXJhOd2/SGhKWeCV37M9EnmoJunqDct4YXas6lrqMwzQGPWcjD8Y9ULh3fgG
         lWOtxK7KacXGG8E38PjrvZLPKPIFDmWrsGt8N86bBQUefrbDFAGjno3xyIeHsys1GNSD
         RJhy9fGyg0JvH8RheyAuR3lXS/7U7MyGzLh0CQL3wkQiXBz+5rlmP8uUpgyXT/mrhr/0
         Xm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744468551; x=1745073351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKA6CW8lkxsZYkZcNj1adEARS2rUQdUi3RNcgzxuj0E=;
        b=GB/wG3zI/7JnzcgYvoMfeNUbxuJjHoj2yu+P4Uo8zD83/XG4LL8LakLW0749kKsDHv
         5T3AsYa+d9v30ltXXr5iXw4Di68TctCsKFuXKOUH+VvyR20ShplnE09T3hOHkgTCCUhN
         m1bk71dxujjb7ev+JMwIbJo78EDnlIt26MqaBe0pMYfAGBQtWAJAg5k8R22P5ln2nf7T
         y81eiaG6wfJlc/tojmHLZAovda6Pk97F550jyMJ8gC3detOkRVqpqg5nsEg4lVwJUr2w
         XbIj4qFGW1Nm0P09BSrNIjgvEIDa8S+zujRhJKAp4ZlG2YxyXWzQt76sDn7WzFL6c9X2
         O3gA==
X-Forwarded-Encrypted: i=1; AJvYcCXXVKNI7vSUgmkKRTdO+M3TLeqLH4zgzTxgm7yQ+72ucSwC3QTH45G7MOpug9tNhSGa82ciBZ8q@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYTNhq5pTXSLkOsg89BdUeqiB1+/KP861NMi4j74F9NzjMif5
	fCo/U0e6ao92mhlkqvaB0/Rbx+RC7r8LM2l1tF6JSJNhQs0D162qu4r0viUmil0=
X-Gm-Gg: ASbGnctXgHISyy+DXmJ2dPkQ3K/z+pg4bBtOKN1Epuw2VNpFrvSE63MkV2QP7sVyFht
	3vLqry+BAF3yTy7cFZpWds+7+xst8ZlaamAc7yuRgvmUThGHpD8T0J+wFi+rkfanValThhdBfiG
	K67fS4ryWRG5VjUCuQDVRESmwi0ZDdn9O3zj98LDxoTT4x+4Qxu0k9zkRJU33KcFXbicawUtO1y
	kaT6Kr6QACjYtn0YbN/rHfzZiNzHb2vu4QPB8EkMmEplVka19624A1BGMEDf56jzj6xVNKRtVQ0
	TY2fhEtD+rsc/45euTzr/iXUFozQPqHEZDsNJxKGWm+ho50ShMkhINBysG3hrYNpL5QOURUVIeh
	rtkTdJ3teTT3uRNiHffJOqRI=
X-Google-Smtp-Source: AGHT+IGqSSEfyQRXlH6VjXNUEfEkbf0/sQSfoUZEWOGabEh6iMrD2lgAmfhikxDIs2A67ZjcfmNMdg==
X-Received: by 2002:ad4:4eaa:0:b0:6e0:f451:2e22 with SMTP id 6a1803df08f44-6f23f15d640mr105210826d6.38.1744468551139;
        Sat, 12 Apr 2025 07:35:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea215adsm50726506d6.120.2025.04.12.07.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 07:35:50 -0700 (PDT)
Date: Sat, 12 Apr 2025 10:35:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	donettom@linux.ibm.com, Huang Ying <ying.huang@linux.alibaba.com>,
	Keith Busch <kbusch@meta.com>, Feng Tang <feng.tang@intel.com>,
	Neha Gholkar <nehagholkar@meta.com>
Subject: Re: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
Message-ID: <Z_p6RBQN0S_N9oAG@gourry-fedora-PF4VCD3F>
References: <20250411221111.493193-1-gourry@gourry.net>
 <Z_mqfpfs--Ak8giA@casper.infradead.org>
 <Z_mvUzIWvCOLoTmX@gourry-fedora-PF4VCD3F>
 <Z_m1bNEuhcVkwEE2@casper.infradead.org>
 <Z_m3VKO2EPd09j4T@gourry-fedora-PF4VCD3F>
 <87jz7p1ts7.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz7p1ts7.fsf@gmail.com>

On Sat, Apr 12, 2025 at 05:22:24PM +0530, Ritesh Harjani wrote:
> Gregory Price <gourry@gourry.net> writes:
> 0: Demotion disabled
> 1: Demotion enabled for both anon and file pages
> Till here the support is already present.
> 
> 2: Demotion enabled only for anon pages
> 3: Demotion enabled only for file pages
> 
> Should this be further classified for dirty v/s clean page cache
> pages too?
> 

There are some limitations around migrating dirty pages IIRC, but right
now the vmscan code indescriminately adds any and all folios to the
demotion list if it gets to that chunk of the code.

> > Assuming we can recognize anon from just struct folio
> 
> I am not 100% sure of this, so others should correct. Should this
> simply be, folio_is_file_lru() to differentiate page cache pages?
> 
> Although this still might give us anon pages which have the
> PG_swapbacked dropped as a result of MADV_FREE. Note sure if that need
> any special care though?
> 

I made the comment without looking but yeah, PageAnon/folio_test_anon
exist, so this exists in some form somewhere.  Basically there's some
space to do something a little less indescriminate here.

~Gregory

