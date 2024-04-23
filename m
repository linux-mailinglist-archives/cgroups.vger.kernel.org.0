Return-Path: <cgroups+bounces-2677-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6684F8AF361
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979CC1C21F7D
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ABE13CA82;
	Tue, 23 Apr 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI18o5+8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6E1350F2;
	Tue, 23 Apr 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888086; cv=none; b=L37pd/FdAemFMHT7e+KLcmrUha0SnEcsikfOzxxp0hH7IO9qhh5hgZwpJNcrbjez6gdv1SEvZPSmPOu9wKitzfnQ6prZf9Jfzij85ICJ75v2o3tf/x3o+/Gi6m+ilrKYgMblVKLdr0VvpHDWcMYX7zRatPwnLzFnAf28tl05yFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888086; c=relaxed/simple;
	bh=PNQBO0iNLxR8U4HksV68EkO7M5zt8A8WHrYsHbxd/yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXeqdgueeOmtc4SYyg9+G1u3x+45DPfGpOsKHfu8QBH3Ce4blGGKFRHSUU3YflnyNH5yclP6yLTU4u0VQaDQw7SbDxu2UFoyeh8PRtbQ6T4VzQxvHeVveOwnhlrR9/ZHIXZbZXYY44RCPoViyV3K9oiqGefjSA+C94Ecnl5LtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI18o5+8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so5406323b3a.0;
        Tue, 23 Apr 2024 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713888084; x=1714492884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AFpeUo5gFWggR9UCj8+ja6/OFl5Ao3dvFK12RV7J1c=;
        b=VI18o5+8oreYbdgVvwP1/z1IXFDiqrBZWFFC/hxvY8b/F0NTNhGv362+BycefV4Mw9
         3ZK2+XqQ0b9uvFq6oaQvcWA9Zq10T8fIt1vyKYfJyUG3o5Dxg5VlPq3DBhznvTCzr+Zj
         PELchC9Ur7SomZVGK3oxzHD7aC+TDyOoiFWqRyiWtYX0ANFK/20d0qhhsQmu8XgBoyMz
         bW2YyGrSAkAPkf/yswKYdc6z9KnT/YxdvsFUe5tF8lFQze1C0hExsgD4q67ivEMCJB+a
         kythrtTugbxphLpZ5hCmT+gBxNf2vK2YOAEiwdDlbUtaX0TpgoKsS+pa13bN0kdRonLt
         LHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713888084; x=1714492884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AFpeUo5gFWggR9UCj8+ja6/OFl5Ao3dvFK12RV7J1c=;
        b=roU+KtizFfj1ebz+F128MjgD/OkCxX9worDweLBETqhXGWwRW0zfnWRrBP70F9QFyQ
         QglcZAGgfScctuy2cuz8gZrrWgWJl/oowCnFYo9koxcyYW6/XQKvVt8tEH5rjETHsal4
         WQX6VtpSfJgeIvgU1nf0wPC2io7RJNTeSTh3TbZScCDRYCY1sJVRFxOyuwJdWvUSF0B5
         wzsXC12jsoBPWm0Tm6rO3GFnDNaibgZyVG6wW0V4wzx0PIoPkjPbNynB6uTMN1auOiwa
         dWXJT1j5jNbo5yY+fp0pOmSZwbzFHQNU7r/ZNOOsfmF7ygPWXHOnDdVSJJV+CPDiXCbY
         tU8A==
X-Forwarded-Encrypted: i=1; AJvYcCXgyo1B5EtrNhOc+VFr/ZaOaaP2V81LUB853hzLjaYaaYychR4eTEqsgwBnG9aO7WKPJ0PMK0YQuXdcvgxljwbR4BRPM9XiyCFvRfGCI59x5aaJOWgjMjO1UdoDAw9vXikR0rM53A==
X-Gm-Message-State: AOJu0YxH3THpnygQH88JJqEQKFbiIv8Mrd7MSBtKUNC57+9GfUtKyc80
	T+B+Uxx9GPm+iECrOwyUntW2b143v3XDEwaFBRtfQpYr0nsDyhYOefFGdMTo
X-Google-Smtp-Source: AGHT+IGIOT3ID+kHLi2YOydjHrPyh0DnhFJisw7LGPY9Wv4MuyK45iFNl6tB3QBeGgVfS9WjZ0JTjA==
X-Received: by 2002:a05:6a21:2d87:b0:1a9:e2e0:1806 with SMTP id ty7-20020a056a212d8700b001a9e2e01806mr14099261pzb.43.1713888083672;
        Tue, 23 Apr 2024 09:01:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id lw4-20020a056a00750400b006ea9108ec12sm9760478pfb.115.2024.04.23.09.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 09:01:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Apr 2024 06:01:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] cgroup/cpuset: Avoid clearing
 CS_SCHED_LOAD_BALANCE twice
Message-ID: <ZifbUdjX6VYCl2qD@slm.duckdns.org>
References: <20240423024439.1064922-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423024439.1064922-1-xiujianfeng@huawei.com>

On Tue, Apr 23, 2024 at 02:44:39AM +0000, Xiu Jianfeng wrote:
> In cpuset_css_online(), CS_SCHED_LOAD_BALANCE will be cleared twice,
> the former one in the is_in_v2_mode() case could be removed because
> is_in_v2_mode() can be true for cgroup v1 if the "cpuset_v2_mode"
> mount option is specified, that balance flag change isn't appropriate
> for this particular case.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

