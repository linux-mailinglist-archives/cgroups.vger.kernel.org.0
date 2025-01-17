Return-Path: <cgroups+bounces-6226-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1705A154B2
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 17:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9D33A9B3D
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BB019F13B;
	Fri, 17 Jan 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="iWzZCpBy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC37166F29
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132495; cv=none; b=u8kyD7D4B19uzTEtb6FW9auaAATjfdzgkQnx5vMfZSBOHm0w6JqVSwNB0UQRPEOI4JzhD+ZEw+nIwlENn7iBIafe4GS583813UMiW+YjEFGajhiecJvfNtINBgMmoNFenC6XWXL2bDlRqUnQsFmszyjuWXhhf/ZKEbTUVl6A52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132495; c=relaxed/simple;
	bh=FQ2koMMWmX5cApEXH+IXNvtfu+A0E4n4juhen6ZDEwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6M92QVZxoP+qAXg+n8LaA6kxXdOMHBwaSIjZdg8kBHRm6H+dbZnFu0nNndq0E3uUozthqnFD7efXi5YPo6afJGf/Bs6R1ClKaK61HuAgS9q/l0pwa3V0Z1SdiKKDIADF8xTfYbOyt4D6e2pORLS88nCaOET/7dSjKPS83sHWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=iWzZCpBy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a3c85e11so15478041cf.2
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737132491; x=1737737291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8YaBSyWTZacAKpiBL4zeCVsLIUHz0xsGOJbxkKSeNE=;
        b=iWzZCpBycPwgly76N+/X9gZaqHpyottFLXN5Ap2JsLdHXvTom+TAeJr9pSQn+QviD4
         SQk2wAfbGmMPCU4HLqcfnwndgxV+r0x9hiE40vkBjqLMO7l8WXTBOaXhht91AscT2FcQ
         VVdA3ySXZK3pHC3fMPGrBQ6tzEFwZLar19mOMYat4lw2l30cSJVc7lkKGTC0K7E+Mtuf
         T2pI4FsgSaCLTIIBha4v7bn/nUxoNkOP3OUdpuh6im1AwV5dfhxyLF4VgbMWJkDdfpOj
         mntWTJcLC5dyroyDHxcqE8DpB8JIfskKbMufJ5UDRtZgrJAZKQV7m5vGIC1arT4MOHl2
         RLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132491; x=1737737291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8YaBSyWTZacAKpiBL4zeCVsLIUHz0xsGOJbxkKSeNE=;
        b=cRadt1FvfAG7uKlpDHKi5gOzPyklObseV1XFJF7zE2xyr5uPa/dj6u0yDv5f/AxbS/
         E5piLpqULAm2bMyvHOtl3V6eE8LMY5doFL9RudQ8zT1Fp67/eXY+2l2eHtS7oh1S/DQ7
         K+GE98ezlbCEgclX8XV0z/8/0FUeU6PWkGqMwCCqdJ6LcFQGwgf9fe9762lGe0Ws9FCr
         At1A5ekpg60zcGoKInxbWSP0bSa3klQUlpdYAaH7eA9foGeZsEYIlLxar89Jy03qBf1H
         tY47dWJu9TcoVhabHRd9mZy1Os6PQCXp/FtEZfhj8COvu20K4rqvfwWIQQqrVuNcHY3j
         JIoA==
X-Forwarded-Encrypted: i=1; AJvYcCUVxE0cYJWe/TUDmQJnhHj4TSmb1zSowsY1BNt+n5RIUQo9rj0YV5fkl9b2tw7sE+NHZJ7WtuYc@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcmpLbYxIVxovXbB7XlhSI5/qYOEGrcOR69O45bomCsrlQvBY
	8MzqyfApIQxPeaIaIQ21FwfCBm//4futkW2io4QYL7+bV8LbGZ395LTvk7m08f0=
X-Gm-Gg: ASbGncuICZEb/gOfdl5PiMfo2ijlr/YZ6WTBi119dvai8+Z+C/XMV/7Qczvs7k4fWw4
	L52FFp9mcC/vmlKfTVVIWYm/CCfcefwvI/w8orO6LfF+C/jHPvuNQB9QgAKLuKmyPChUKOw0CUo
	/lxWgI3tBWwDKuIujZj0S61lT3ShR+zGGJa9S+DuIP9IDRuAzHPNXR8omLUzH2BiYqdGX26aqI8
	IPPN8TOfaxoPEOm8FlV71OrKPQpUiFH26xcd5NQQMAT74rR7HzVFSM=
X-Google-Smtp-Source: AGHT+IHnKmujOhexofpW2cCRKOdVd4mgH+9RWl0NrA2BUuwjZsr+vt7twxWRa+WyYfI3I0Pnq20sFQ==
X-Received: by 2002:a05:622a:229e:b0:467:8797:29f1 with SMTP id d75a77b69052e-46e12bb3aaemr46795911cf.45.1737132491435;
        Fri, 17 Jan 2025 08:48:11 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:f0c4:bf28:3737:7c34])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-46e10323c3fsm13162711cf.48.2025.01.17.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:48:10 -0800 (PST)
Date: Fri, 17 Jan 2025 11:48:10 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3 next 3/5] memcg: factor out the replace_stock_objcg
 function
Message-ID: <20250117164810.GE182896@cmpxchg.org>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-4-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117014645.1673127-4-chenridong@huaweicloud.com>

On Fri, Jan 17, 2025 at 01:46:43AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Factor out the 'replace_stock_objcg' function to make the code more
> cohesive.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

