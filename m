Return-Path: <cgroups+bounces-7957-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF331AA4F10
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7990D4C53D7
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5594C19F40A;
	Wed, 30 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fYa9NHW/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB211A3179
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024559; cv=none; b=UovZnrpofG667bLbr5RK1czOFr0W0LUxC2NEF0VDB9dljxSXNCPIGjHaYc6PwVMWpXWyFPjUZYVTZZ9IQEwn9/lmBb0xgrm3Is/Fcz09tqS0oY530FeWvW6ZatMkNGUDCQA+XXfsJM0EgS8axoPJ1iW9junn3qSl9rJSNPQ/gmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024559; c=relaxed/simple;
	bh=hqY/EnS0g1ASfdxS5QE/RWWkZtTu8k1TkzIqE50G7No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YimEm/ObkqVQj9joLUK9SymaLrqKx3nvxgbs+pQxGS6vf68WBnHJY8VsmB7azNd9nQVyo2be5U2t8AZMzvIHlEeL33aSUKBkbUa82OkkRDifW6x5qPWQXAD/wOApXj4kU0lBpWWJJZwqhcY8r/M1yfRwqFu/3Mz5OzjmCAsdFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fYa9NHW/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c55500d08cso812542485a.0
        for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746024555; x=1746629355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAQavjtHywDtkfWDi7d5KrAtXnOwl53XsLV1VpcfMts=;
        b=fYa9NHW/i1bKF2r9/oGMgPR0Gfz6RLsLLQj5bLqH30XswVAB6XTWX0ZKE1RwuM7SpG
         xcHKMaTyvIxaFqPs8E8AsrTXtU7ybe8XaiOTvj4bkxpxvTojWQ+l2BKbKXTtOkjVQqno
         nZ/ujhSc1GHKjHFogw89scfuvY2xEhroKwbor0VufDFJut8lD7abyXXuNLiKtAb7HBs6
         11ncQAXVpgipapBkTE3KdHbxq82+CVZUN/J9mDC6CcDHM4w30CHpwaR+8424cQlpEbVh
         CkzTd18fDJbNJWQlFD0Plkyn0Ay66ZM1mr+8pUOcp44og0QRzX5TEgytLx0lh0IpX8l5
         7mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746024555; x=1746629355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAQavjtHywDtkfWDi7d5KrAtXnOwl53XsLV1VpcfMts=;
        b=N/2aCvaMJXyHfK4RqUiTgynGSZgGLtmUtL2equfYdfnLXN3SLn5dc8m5FmV/yIeZTR
         XQYFA6zcQOLYy0scUqSNQ0561M9+cfC+QbMm1QhIYgdVYPNlLzt33MTTqpiTOP1LvVCa
         V4sBRoykz+aVVamL2ufRSEEf5whdpr8asxaf6A+7ZNiqnzDC2Pi5oieu6ncPRR0AoRAn
         N/irf6mGwaMVMnhRcwM167bLnxO6kCkp77GFYZc7cwH4SrucKqppz6k6+4FeCNRfYPLM
         jHvJLbmUJPbgPWS/Axqa/0bznp6mn8NiHKKUu+L0O2C11H7j6nRAS+/jmujz3y5+y3ou
         LSPw==
X-Forwarded-Encrypted: i=1; AJvYcCWuDIo0xUXtCK9SmIZH/5CZuuCYugq3WuAmMe8E3NSO1NHCKLDiF09bCveRLuP/f4UKRZC63qYy@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKAD8fnoktuUcwnWUig7Kl26/KWs1YIQL5K0ESxF15xMOctni
	rm4Jd9VdMHdLNUzsNyUz42I2HkRYL1XhunJ14W7USIil/VTlq1SvCXMTEVd9laM=
X-Gm-Gg: ASbGncvyuMGIpVdQb2b1lYcIexFZu7fjjhR9wJcucdWrupiNBf1USf7ySp8H42NyY1w
	TyeS6JvTgWZbCCqqtxZmI161X5iKJOCLYMX11pFYgsFuzECUskl48MQAE2smG000anyHfupvOQ0
	626njowwmRuedk9W2MWwNsjUNpZtESRoJegGA8k2yAZz/99K0Yc2F37ykOiNhGamH/u5WyhRAWm
	BXvaIcV8D/PFtrMX+di7fImi2Kf7DIZyY17Sm7yvKOcapz2FMoQu12vE1Rx/IJGIPduWmnGmg2c
	gYF508J2RB6VzZlPCjFAdN63f+6/6ADdnAksi24=
X-Google-Smtp-Source: AGHT+IF/96hom3+JLrgXk+J7xCewYly0PcXOER+WWiY7E5OjDkUIEfEPnoq4AJrHoZ/ktBIx3YvJ0g==
X-Received: by 2002:a05:620a:4056:b0:7c3:c695:156 with SMTP id af79cd13be357-7cac761117dmr431803885a.16.1746024555355;
        Wed, 30 Apr 2025 07:49:15 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c965750a69sm656679585a.1.2025.04.30.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:49:14 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 08/28] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <20250430144910.GB2020@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-9-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-9-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:12AM +0800, Muchun Song wrote:
> In a subsequent patch, we'll reparent the LRU folios. The folios that are
> moved to the appropriate LRU list can undergo reparenting during the
> move_folios_to_lru() process. Hence, it's incorrect for the caller to hold
> a lruvec lock. Instead, we should utilize the more general interface of
> folio_lruvec_relock_irq() to obtain the correct lruvec lock.
> 
> This patch involves only code refactoring and doesn't introduce any
> functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

