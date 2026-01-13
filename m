Return-Path: <cgroups+bounces-13150-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C452D1901D
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F9E63008781
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9938FEE6;
	Tue, 13 Jan 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mf6RFr2Z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E038F936
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309500; cv=none; b=Dus5+Elm4noGEJEQ6hun4HNPxohW+hot5f+5No1/R8rxtxhYdskyQd3cR3z0zOxahvpG/A4hjg/JDI6kHK5fV7xscamFuNAqszIQZkAYqu1cY/gcHRipfT57ZDZ4RsYV6xgZ+yUg2m7f58RW/EcHjLaDgAXU5PO6E+UrO9/tXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309500; c=relaxed/simple;
	bh=iA4zp/nF0mWvJTMD2gLJQ5Jx06t5ceJtNuIFoxyW7pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lo2PXVKeF4G3lKcF9XQ7rSSML0xpPXizUQS7sfvWvgDJpVIUOQ5SVxKDI6g93w1Gf+DMGwXrR3bPCSX93Mqc0Qrcij5TgfTUvhcWA847SOiQL7zVLdvLLmwF9uc5ea9TNnnizrzheZh+H3IpPP0t0nUtekSS7Vjs/Rhu4P+f624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mf6RFr2Z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so6344412f8f.3
        for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 05:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768309497; x=1768914297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxmC2pl6C99HyG7ZtcQQ6tBlfEFY9dcUww524xGSm2w=;
        b=Mf6RFr2ZB76jISts44F3bIDokXy0DNMNucG6QmFjA205OKTR46C23kcOdk1Jq6Vg8D
         i+4Zka+Tnf4SVJMQA2svS5ZgiD3rRWqeXmqSTP6gH43kQ2yOl8abW4tuVfKCw6GPMjBQ
         atsK0wmjBN4/lKle7BUyCoK1juo8hozO3y3VeSu5h3BBInxOgKuwes8Xo5YTuzBrcF8M
         55bjg9ptCBMjbaVF4S+fxihsdU6r/Kpd30QsolNoRe1jGxupF+inek4HA4E91EotwmOx
         oJo7ttJ0xdsTLmn/JRyJ0Mv+GZqIXVBb9aQwrttSMWltT1OVCl3gTw/58xmgDDxD36Ke
         BqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768309497; x=1768914297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxmC2pl6C99HyG7ZtcQQ6tBlfEFY9dcUww524xGSm2w=;
        b=tNaYbLK4Km61cZ70aCL6OfREe61oGZZc5YhCmV4ZZyPzy7Jv7xvDgCeCw8qebfi4sv
         DhuwRy0imE5GXfhIsLnaAwxRwfVjnwyOwFeNrcEhcjtqQLXw9mP1HHH3yAnU9di7/5eV
         0G5SGxSQ+M7Kk9mJ1pkm89Axr20cOCIrtTJHU6IFRgpfq2fmaZPhpBx4EDHMtudjXgS5
         HpnkMEeJn5eIsX2RgmPfGJn/EgN9/PZ5m1Znq9PeWWD2MKDI3/MbTkfMcJOSIhFkvxES
         l6fWGlaBbxsEVkNAl4bCZri+UbVcJiStMaHs584ICXAfwsjQOCJADjXGIMCKOOkqyFF0
         3KsA==
X-Forwarded-Encrypted: i=1; AJvYcCWcWy3xkGkXBcc+SLc4NS5iCe/7Toxd2zDd6Px/6Lh24T0Q7ZA58UEmBBgDlC/IfTlVNex/R9Qv@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdF8H6ZU8d6Y1saDnDG19PRTaKYwEYAQwFphSUJ0qhH0Qy4zY
	xPvzixzLhHc38OTrDaN7/fGes0W49rt/FgZN41oGRZ/n5NkaiiuRayW/GMStgIl105Y=
X-Gm-Gg: AY/fxX7BQUZpFhPlsNmrD4aH2n72vVsk0xx7ZKju2IsB/eLdVSB2i0ynNIz6IZZIWpM
	1QMca5TkpWDO7XH8QeX3Q9w4r8naBI1E8so8SAM/hgrhycX/9HECbmXQoLdZFmXiDne4j9e8jEK
	yu1eYrC8bEV/9/ZAsiVIoc1p7vbeygUE22lvu2/jerb0FacC411mUWsrt21f7Z+O7AilhaYV+eI
	XSXUSxFupDVXRaRporcZ5jk4Q8bL3OYBVM+lB5lhItc19904amjJe8k3ygQ4PGYE0FobW9jgXud
	UufEhkS5qoxJTgwJME7jjA6vYQCZsKc1oY/qXWd4D6Xw1ikU2sQbME93GuGuVFiWxLw3eaEQ/xe
	KWA1rKjU4INqNyJWsZrJU1fCZuo2P6C4MlCH1afgVLYmWAHF42WFWGQpRzSvCnE2XBatae9WdJD
	C3MtPS0AjkRSaxVjsCpjp3t5Nl
X-Google-Smtp-Source: AGHT+IHYXSfKeSyIbDj42AJBJmOhERkm4DTvIbdJkdpUx9cQfI7l/3M79m07YpjVsO6HUGzDbyppzw==
X-Received: by 2002:a05:6000:2912:b0:433:42d1:f71f with SMTP id ffacd0b85a97d-43342d1f736mr7036326f8f.38.1768309497141;
        Tue, 13 Jan 2026 05:04:57 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe67csm44077240f8f.40.2026.01.13.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 05:04:56 -0800 (PST)
Date: Tue, 13 Jan 2026 14:04:55 +0100
From: Michal Hocko <mhocko@suse.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <aWZC9zfTaBvtAJ0B@tiehlicka>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <aWUDXtsdnk0gFueK@tiehlicka>
 <7c47ff99-4626-46ec-b2f1-f236cdc4ced1@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c47ff99-4626-46ec-b2f1-f236cdc4ced1@linux.dev>

On Tue 13-01-26 10:34:08, Qi Zheng wrote:
> Hi Michal,
> 
> On 1/12/26 10:21 PM, Michal Hocko wrote:
> > I can see that Johannes, Shakeel and others have done a review and also
> > suggested some minor improvements/modifications. Are you planning to
> 
> Yes. I'm working on them (mainly non-hierarchical stats issue reported
> by Yosry Ahmed).
> 
> > consolidate those and repost anytime soon?
> 
> I'm testing it locally and will try to release v3 this week.

Great. I will wait for the v3 then.

Thanks!
-- 
Michal Hocko
SUSE Labs

