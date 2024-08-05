Return-Path: <cgroups+bounces-4100-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF9C948567
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2024 00:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DDA1F238C4
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 22:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4863416CD11;
	Mon,  5 Aug 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZqM8z20"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332515383D;
	Mon,  5 Aug 2024 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722896202; cv=none; b=KcdcJN4NcbWWZjVH3DU+g5GcwePgA27KcQhGHYmfDy/NKC3dRYzzAbhdkBmt+xQSfynaOx5iSm6sFBQ/PV11imL+x61WjDpuv7VGVIWSRyMPXjaZ9J0Gg9rCmBk5/IydECoHxwI1ER4w3fumNWMO1ru8a9FAHK9w0nD/sjBg3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722896202; c=relaxed/simple;
	bh=GwjPy5qvxc8ztQEwnmZB3b9lsTRyRQso27qxi7VRmss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c51XzyB+mYu6nwE1wyBvoiN3Xq1IasiNd530izR1gAXdYI1Dzkiq5YHPtj388pg5spYM1tr/TgBwM9lTLvRf/FFQzSS9KjqMMeTHKqPKqa+AAaJTTYycwQRik2ZRKEH7z/j8V6lEGqVElsCoWQw8W4SjU7ajzMIvSr4x3AQi9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZqM8z20; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7104f93a20eso4468704b3a.1;
        Mon, 05 Aug 2024 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722896200; x=1723501000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDP0254ZKHoH3WdSUH21sgFodLciHrxHRbfl7gptncY=;
        b=YZqM8z20BRzNYarYRm+mE6SS6gafaa6k/tQP2tyrkHngh9RipCyujg0SsJkC1oUBXF
         NqbuwSvCgGlGrwgM+eLidzKd6KN3W3nbi0UcXN10C9tRzQJLg2nE/Cd8JyRl80BLmTex
         Fdd6Jq+b1S9IQYjeF63IZq5Ge9x30lu0FDrPPni0wdDDZ8NxQkWxVngVSLfHv1jg2LdT
         1Rpxbakd17XNiZJ3oYmSU3KehCkAur3liMRJd3gfvX+SAHbfDa7cz5L18MdB5PnKil7s
         nrBee/Fhs2T0cxUedMwBOyHysLEWMpexwPmWx27kfjI7vzMVxa7TYT7bd1h3l5tHJ4ks
         n3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722896200; x=1723501000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDP0254ZKHoH3WdSUH21sgFodLciHrxHRbfl7gptncY=;
        b=fpFYzCon8Z5H6+Q+QSB/h8dP8WaLSZSYnM6BmBBHfVlOplGa9LUSkPAJk4NkoRvgx/
         xlbPaOmNKyo4W2ATCcsThbmTodUnZ0rmznU/qUZdkvuj5yzWumE5XclezDHyCrUHKW8w
         1xnb9s/evhu1uYB/Sxo7tG4RStTxekmnsMYLIhI9IElNef/AmSzY9ShTpH0wGZOqOrTl
         YGGF3/gE3g8CmKtq6ebdLypjMaDhblLeM9g3GKsmpM1VB/Ts6IFUik5eZZj2bcvO5mQF
         so74EMriBNhS2OJYZ+19uV0xTR8ZLp7/gNleR7+9ij1dhD7mu9dssJAx+jf+LLokVhaq
         +Xgw==
X-Forwarded-Encrypted: i=1; AJvYcCWL4X7U59vcCtqdU2Ia5dxj0E2MaXCLpTsWH4gfVooO14NnxGRVlzLrfXVBLJc6rTWlkjrREBNwbzl8S9cpPZy/yuJ0L0Z6kwAvris7G+zsPhIfzRLjvXlhthsr+i9P/b0pU+vK0Q==
X-Gm-Message-State: AOJu0YyBuWHLdM9KBW2UlssLzlV8ac/yOXij0uiIl9gDJqX/bvqOkAZg
	a9cqNW+a/WWxiPlmb69yy1WtMJoQV0+XGqIMBPUO8zHKJrh1ihGZ
X-Google-Smtp-Source: AGHT+IFlGKOvGC1WXMzh86932DJ/gVXcI8fmnXInW6XfyjURS0Xsfpkg2eYu7oX3hkxfNcuEP6jeWg==
X-Received: by 2002:a05:6a20:2591:b0:1c4:9ce8:e6ca with SMTP id adf61e73a8af0-1c6996a039cmr12725958637.54.1722896199722;
        Mon, 05 Aug 2024 15:16:39 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec74068sm6066014b3a.95.2024.08.05.15.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 15:16:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Aug 2024 12:16:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: Re: [PATCH v2 -next] cgroup/pids: Remove unreachable paths of
 pids_{can,cancel}_fork
Message-ID: <ZrFPRjhaiw5KI6Me@slm.duckdns.org>
References: <20240805004304.57314-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805004304.57314-1-xiujianfeng@huaweicloud.com>

On Mon, Aug 05, 2024 at 12:43:04AM +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> According to the implementation of cgroup_css_set_fork(), it will fail
> if cset cannot be found and the can_fork/cancel_fork methods will not
> be called in this case, which means that the argument 'cset' for these
> methods must not be NULL, so remove the unrechable paths in them.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.12.

Thanks.

-- 
tejun

