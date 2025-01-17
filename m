Return-Path: <cgroups+bounces-6220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EEEA14E9D
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 12:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA4D1888051
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C261FE46B;
	Fri, 17 Jan 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZGnh2ci2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935719992C
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114239; cv=none; b=Of2Xqs62B8pCgSzTS33pXLCSCHP4sr7zu4wQFBqlEU4hRAge97MdP4GYtLX4fc+uHYcPmTmdmzLdv3ZRv69uplSu9LkvZ1Ve0LomVLoM2Qth3RY+UuqhVH92SwJBf+VDPGI5rG43XdYnYU0DZhRQBDyjrc82dVLBFrnw8LmJSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114239; c=relaxed/simple;
	bh=x1pZ2+NWWGFp00TYoCsdcvWhjXVo0gEuAeli/wzRMVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVJ3fbUrcXXVnyxh9p0omRMRw2SLDAGgKFpzbk7WvnDOsefRzXPpav4o0Xyqs3vLx+wwjZgF30gYSancSF3EEpDhcXes12bWs+WSlVK6Oc5MP7iSf1fbLiXQZLpIY3ZQctvxf7btLUXF7Y1DNjIwU8/vCAtFMyo1W7xCmzf9DE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZGnh2ci2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436a39e4891so12857755e9.1
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 03:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737114236; x=1737719036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUuW6LaXAzQ4ddmq/8F+bgdsSQzi5OE6ZPQ7s3KDBMg=;
        b=ZGnh2ci2hdz1XnahDspkBI3m7zBCeDo2l33n9ow0hMNYMAT1SjkJJYVDRBvK42P+lH
         BVCpLR1i8XfrWTxK2WUgV0SeD3xsE/03SDGLv05VcPIXZHFPtSPK+vxur5JQ/XTDw4C4
         rNd0cIBw3zP5aSCKEEZ9lnIXfFHsIZ4Kn7Xl6gxJG98s2RVYq1E965h2lorNxYvrKhQm
         H2UMk2NWROEozxJEQDyy7GamyvyOiYf12NOhjaeN2juOFHd8F8D+PYsawOhXMkMt6YZL
         J+SJ02dyJc0vqlGz4vUOYqpyyu0BAS6u0ruTHJVGTOlPCqgZkQd61rPsit7LaHpCGZdv
         M7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737114236; x=1737719036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUuW6LaXAzQ4ddmq/8F+bgdsSQzi5OE6ZPQ7s3KDBMg=;
        b=O27igEsbs4gAr9ld/32LMrMkbruN2AMatImnEIQ6S05Iyr2G/Tvjteca1LMPlW8q6o
         /nOrmXlpxFIrH92OpHz3zUAIEuvMamgCf+Fdps1o6X0w8kS+eYleAohuy3q8AiPS6+B7
         5shl269f6+PZTQYJffGcv2Huk6KgWlXD1vBQ06KEkF0KX2AdwSKMQmryzxmzCGytt7zo
         KxaAo7g7heOFcXh2IlNLz2VGDpVqDiLYaE5NtUGOEK9IVBDPKh3wfPjxsTzJu7JGz1z8
         VuCwv7WaZTNTcHSHJzeTKLwrQLv+ixphTadEHp/bS9A/j1TOVphPMIFhua0LwZtuPhHy
         vBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWubPiBepBOmBItBkE8+gYXQM2BtMiYbOWMqknI2fMT8MgzNo7r9XHkijm/ZBWW98aRcVIPnvBi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61Nvbd0VMl1oLaedeiNpAHhNC98Y+JZETpOeRbggJfAxTfGVl
	WB4i5wR6pLLiD24ytPUm/rYeOO/DR8NR/5hL6Bww9CNlr2Nq4eESS8JUe6B36T8=
X-Gm-Gg: ASbGncum8+q964oCTKPc1cHXTalO4RyK3mobW0XUCjNE7xVWc1D932eBYRSMoDQMniq
	aR+WxobtBqq5FXZ667NaFHTEbck+Mvd5fGZ5H/Yec8BGkUz5FVCykS9pFRnIQM13C7TLk99gWQA
	SPrADehkk1PMqdJc95v4rkYRDMO3lJ5gCAzxnHs/JV7MU0t0Wj1bsP7kcolLKhzSSCnkPVKvvch
	QxbDQZNWO34qfZsHCDpLR54r6BhEb+5AlJS+2n+gIa3+2Hq1/LBKdjhDI6ZDgbBfD4j7A==
X-Google-Smtp-Source: AGHT+IFaHWJbC48oF3hpgHSBXUqG6jy4KSI+cLoiycTrsPbXkX+F6N0oMZn1e4sry1caAjXknYiBkw==
X-Received: by 2002:a05:600c:1389:b0:431:52f5:f48d with SMTP id 5b1f17b1804b1-43891460bbemr23967465e9.31.1737114236195;
        Fri, 17 Jan 2025 03:43:56 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3288f79sm2279111f8f.100.2025.01.17.03.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 03:43:55 -0800 (PST)
Date: Fri, 17 Jan 2025 12:43:55 +0100
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
Message-ID: <Z4pCe_B9cwilD7zh@tiehlicka>
References: <20250116142242.615-1-justinjiang@vivo.com>
 <Z4kZa0BLH6jexJf1@tiehlicka>
 <a0c310ba-8a43-4f61-ba01-f0d385f1253e@vivo.com>
 <Z4okBYrYD8G1WdKx@tiehlicka>
 <3156c69f-b52d-4777-ba38-4c32ebc16b24@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3156c69f-b52d-4777-ba38-4c32ebc16b24@vivo.com>

On Fri 17-01-25 18:25:13, zhiguojiang wrote:
[...]
> > Could you describe problem that you are trying to solve?
>
> In a dual zone system with both movable and normal zones, we encountered
> the problem where the GFP_KERNEL flag failed to allocate memory from the
> normal zone and crashed. Analyzing the logs, we found that there was
> very little free memory in the normal zone, but more free memory in the
> movable zone at this time. Therefore, we want to reclaim accurately
> the normal zone's memory occupied by memcg through
> try_to_free_mem_cgroup_pages().

Could you be more specific please? What was the allocation request. Has
the allocation or charge failed? Do you have allocation failure memory
info or oom killer report?
-- 
Michal Hocko
SUSE Labs

