Return-Path: <cgroups+bounces-6217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A45A14C3A
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 10:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CA83A622F
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E831F9ECD;
	Fri, 17 Jan 2025 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gkQWfE2z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582771F9409
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106442; cv=none; b=iGBFVYhCrWQK8eF+JTiWE5T/lrGDozCwez6IHEbqri2GT83SmngheXFQGZZXAHCBd+FW9ISbSt5yIP2QcjoXeWnL/FcKdUfJ+0VBzv4Cywt+RbRUcwHCFc2iYtAx0jrzrWn/bcrKz4Z2TswuHoiKteZi3+fk2mlMJvO5sgHKETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106442; c=relaxed/simple;
	bh=cnITsTvGmNqhJGWq2jKzgEF3ZQHDwDL3o92KopbghWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZi9PRp45fOjyYK2wQd+e3K//1SiXwdgkv3iF/KW2+bZ0H2wDlEyngmiNwxvEF66y/zEN+yqFU+PqeauKPfbEdYISWvXNVVzC66enh51+c0ylfzXixhLg3VqHAF6kqHbvLV+MwUumyr7x/a6bKz60g4IqIRH29quCYLR68MtJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gkQWfE2z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43635796b48so11629275e9.0
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 01:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737106438; x=1737711238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpEcDbL12pVoi7d2pYABiZaYKE4gVvTaOXo3VG2boqw=;
        b=gkQWfE2zpPs7mEBNlUzWvrbhH73ncOPsixsYNn/GDGsflZiz+s/MT2GiKBvM5TwSfZ
         /iJNWuT657Syofn9nCK0naUtPYVFKjvGVELgKfeUcB+lkAPMWkw3Z2W4S+J4NdgqRw3q
         1kXkRvBTEHEIWyvCWIRhRkNuj7dZXrWS8alCBBDH/Hi2XFjlNLTB+cWP6LLkOqyWMWxc
         XxQ8MNjKzgUk3DAe8qxH2/w28fzAjtFe1JgPqfa5rJ8avDS11uSPFa/TKtGx8s6Lf1HI
         MfbIsdubIUd53GCMKAvzEi8pmJ6BPRs+FL0wo/ZXIs+Snc5C5DOQNyI7V3Ai4cQzPqU0
         XAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737106438; x=1737711238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpEcDbL12pVoi7d2pYABiZaYKE4gVvTaOXo3VG2boqw=;
        b=XF5BC8UQr9d7NR2c8lVBTvTsZmxVsY52gUObDkET7r1TT7bgEzeSGlmoxmNK0ej2py
         C6f3Ne4rzh+EVpTFi5AfR8Rtqd6wi4FJDtmyxfzLe5FD/usedE0LciQq+act8uTVzonC
         ld0cxJUNRPrl72P77+KhMiTxvM/bhtkJ/d0M5uEEaVB6H2tcPrtje0/RAy6hlSebTwR1
         H41Sf983gwjG0xS8rw7ImF5T7vwl13zaYqLt/CgqFus/0y08w6myfOqp1zePBCeFdpdg
         2XtZNOTA/Sc9ErQ8FPnN5aTwCM52IOGtQOI2mY9ZpSRDZW7Jnwm5d/xO7/W2UrzbzTwI
         z7BA==
X-Forwarded-Encrypted: i=1; AJvYcCW+LueQJS0yFbaxhx2y+4kYUMEjUQqhxTdo0/ktN3hT5B8QzGZnENTmBkdMgCX81jT0lmGeKoMx@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2fPoE8cbl7kvFUjwhFuQtEO8ps3MzQTc/OQ0Bds3X9ig6/70
	+A55XaxcgMCG9lubMTrVeR4xBk0CUzcm14SjtCAQbp4h8Bgz4AMiYgMyOUVmgkE=
X-Gm-Gg: ASbGncuyZeU26cSmrm6MWwrqKp1fXDWQQyuDQjvhofd4Z3nPnfv+9HEprR/yJDAkj/9
	tWH4YlBmI19HqlZw5Ab4oRdaW3weAtl+e74nXxbuKq4CGYfufy4j7/POsLoUKfjfqtHu6xt1n36
	PAq5EDFOlXgN+5cjB+stwDyaLhjKL3KSnJth/D+BQbx0BEAU/pDDMwUAgutFwKmRwc8Am7x+9Kh
	+dMIzNFrBstqdj3RXMVEBwlmbLgAwqT0gf5yCID5y6TBNE1mEPvXIz7xvj7oWSwp1ws/Q==
X-Google-Smtp-Source: AGHT+IFFj5UxXG8t53dNKmaUTxCG+4Bqsl1WEiLZQzzk2+K5RgvbOuitcW8UcJVnLe9LnQvdnrJyeA==
X-Received: by 2002:a05:600c:3481:b0:436:fdac:26eb with SMTP id 5b1f17b1804b1-437c6afdb21mr94369605e9.7.1737106438583;
        Fri, 17 Jan 2025 01:33:58 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890468869sm26761175e9.35.2025.01.17.01.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:33:58 -0800 (PST)
Date: Fri, 17 Jan 2025 10:33:57 +0100
From: Michal Hocko <mhocko@suse.com>
To: zhiguojiang <justinjiang@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: memcg supports freeing the specified zone's memory
Message-ID: <Z4okBYrYD8G1WdKx@tiehlicka>
References: <20250116142242.615-1-justinjiang@vivo.com>
 <Z4kZa0BLH6jexJf1@tiehlicka>
 <a0c310ba-8a43-4f61-ba01-f0d385f1253e@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c310ba-8a43-4f61-ba01-f0d385f1253e@vivo.com>

On Fri 17-01-25 12:41:40, zhiguojiang wrote:
[...]
> In response to the above situation, we need reclaim only the normal
> zone's memory occupied by memcg by try_to_free_mem_cgroup_pages(), in
> order to solve the issues of the gfp flags allocations and failure due
> to gfp flags limited only to alloc memory from the normal zone. At this
> point, if the memcg memory reclaimed by try_to_free_mem_cgroup_pages()
> mainly comes from the movable zone, which cannot solve such problems.

Memory cgroup reclaim doesn't allocate the memory directly. This is done
by the page allocator called before the memory is charged. The memcg
charging is then responsible for reclaiming charges and that is not
really zone aware.

Could you describe problem that you are trying to solve?
-- 
Michal Hocko
SUSE Labs

