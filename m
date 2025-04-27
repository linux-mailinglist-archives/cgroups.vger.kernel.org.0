Return-Path: <cgroups+bounces-7844-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643AA9E2D7
	for <lists+cgroups@lfdr.de>; Sun, 27 Apr 2025 13:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFF217E982
	for <lists+cgroups@lfdr.de>; Sun, 27 Apr 2025 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D112522A1;
	Sun, 27 Apr 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RdjKIPch"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F512E5B
	for <cgroups@vger.kernel.org>; Sun, 27 Apr 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745754375; cv=none; b=TEEY2aJESu4Por1GVNOCJTr6oeqPuMmgb5iV8daqHtka+BhspiF3JxqCu+/Jvn4xIUoyhm9TVzewjHhVFVm1Qkn+o2ibq7TiJeBKKARbdJy6jw0wzMMmaDeQZ7bzxE8Rv+Zs9aWZsLpzW5WX2M4PQektRN7l1VYgxHQvE/LM9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745754375; c=relaxed/simple;
	bh=GVctOdu9pd1Tstg7D7UihQBXqtIW/DBOfarRRGN6PSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPVY9Y6ugp9fjqOcB47+aZl1QTFRakcweXYfHqMZJQpCiS4NC6cDmvA32mb8nELoajVPbnlUQIdaJ7RVRjM6U/gCTzYwR6z4bxogS8/ISnTJ5OlQqqY1YtfDdIyI/VonOsKwwWXW65jRI0Qb6lmCcI5B37ccHLJZIKj89EXqols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RdjKIPch; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f0ad74483fso44403716d6.1
        for <cgroups@vger.kernel.org>; Sun, 27 Apr 2025 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745754371; x=1746359171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZGJbKlltLESsmy2RtQuwiQRyRDouUOJMZvq+iV0S+c=;
        b=RdjKIPchcnhZ7A7je/Inq2yWc0Ofon2ElA6dvrqZiBNtN1qaqj58MhmEJVlot5qZmu
         Qq/Z7BWBibl32V8eqeq8NEjP3PQtlDEFgA8K3LC1oH5y6uC4BoGQb6NYctRg7ElL5XnP
         lDjT3+/AfIQw1G/lqXMDyj7/1rDcWYlYIkhdrV9SrOSgOOei0rlDxfS349N7SIVS3ZsQ
         l6TkQAdbXelF6sSFEhI+v/q8OkPA3SS3Yj2TROacp+dVY1qK7qupN3LGwhagUuOY45Wr
         Zi5u9HstpSjYroc93T7vJ7FmQg07Aw2ltn3L20vwsVYcZgmOo+3CtdQxKwpnyva5MROz
         G7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745754371; x=1746359171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZGJbKlltLESsmy2RtQuwiQRyRDouUOJMZvq+iV0S+c=;
        b=es/cHnUgMsRaVKB/TaU0cq7s4tLzfAb4iDx2rmo3ow3CYzreh4N3pcG7jzFYhwQl/K
         J3d10cUlZS7WWKJHM8BxzwF1K026Oj4hGZjdLUkj3ZqZ0VnSC6DqneuqD3YSIUz4DA/2
         VN82+g1uuZJxN5bbsNn2P9xbmWD06pFPEbZv5Mqp7NRFzUpU/36bj+CI1mBtLylY/sV+
         uaGsvg20AqlNXljAZXG5WqkI4gpwuhcQXUdqeGW+XXLODY/4WXJmj+Z5rbipCWE4eX6O
         TnPD1RgibYkQ8lpmR+mzbbB/+MCAaKybL3N9Zrc/ASZxXeXj9Mw/QSgZHFErTcHhkevb
         iESg==
X-Forwarded-Encrypted: i=1; AJvYcCWy25slBstn9ZYw1Rd3UkEX/4MW30ELqinNY8AcUGTCpr8hQMmFQtWH5GPy+heUqAtNcnEGamRf@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPEaQS3iRM5UF4DcpbY0VAKLYmLnLXZ9rctLbLo59SmQAEKDK
	i+udMjJQ9x6pMsx3BTmG+XXDjbUnXvGLhQb3LyrouumkdFTMhd1Xcenbdv0Qwv4=
X-Gm-Gg: ASbGncvyJ0CIfQQmpoxxGw/59O2sdQVJmPopCrTm1vv+7uAU57tzRP5CqTSm5O39maw
	BUcfxHDScZoFOxzTpcw+NuEdAdTB3Ma7gKaRLIQJTv9JN024aUBmnCsQ83mURR6LpupabGSFG1k
	Pf+6T02DQHIHP82cT0eZCcPgo74IXRih9S2nK75WDBmK0RCZqUrpLs/3jMjRsKEjf9eGPpj0Crt
	h4KefLKXOr804g4VDd8JdXiwT5sYZmqF8p6OcyOEmA8WxDGrgzQrO4VNr1JBdijbVRFAfOsBmYc
	Fc6tB1vFPZncQti8KcrmUO3hwj4RJVY8kcP2uiI=
X-Google-Smtp-Source: AGHT+IGYlNv9jjm589wH0WvcGrTx5hwBX5PzvIp+I5YJ3ZPlUly+7OZNNemuhxWqi75Nw+gnuzcHFw==
X-Received: by 2002:a05:6214:2aab:b0:6e4:4331:aae0 with SMTP id 6a1803df08f44-6f4cb9ba3a9mr120420376d6.1.1745754371307;
        Sun, 27 Apr 2025 04:46:11 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0aaf98dsm43731706d6.108.2025.04.27.04.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 04:46:10 -0700 (PDT)
Date: Sun, 27 Apr 2025 07:46:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Huan Yang <link@vivo.com>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Francesco Valla <francesco@valla.it>,
	Raul E Rangel <rrangel@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	KP Singh <kpsingh@kernel.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Boqun Feng <boqun.feng@gmail.com>, opensource.kernel@vivo.com
Subject: Re: [PATCH v3 1/3] mm/memcg: move mem_cgroup_init() ahead of
 cgroup_init()
Message-ID: <20250427114609.GA116315@cmpxchg.org>
References: <20250425031935.76411-1-link@vivo.com>
 <20250425031935.76411-2-link@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425031935.76411-2-link@vivo.com>

On Fri, Apr 25, 2025 at 11:19:23AM +0800, Huan Yang wrote:
> When cgroup_init() creates root_mem_cgroup through css_alloc callback,
> some critical resources might not be fully initialized, forcing later
> operations to perform conditional checks for resource availability.
> 
> This patch move mem_cgroup_init() to address the init order, it invoke
> before cgroup_init, so, compare to subsys_initcall, it can use to prepare
> some key resources before root_mem_cgroup alloc.
> 
> Signed-off-by: Huan Yang <link@vivo.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

