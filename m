Return-Path: <cgroups+bounces-5083-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C199996D5C
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 16:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297AA1F2569F
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D4199FA7;
	Wed,  9 Oct 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ledIG4vp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4261957F8;
	Wed,  9 Oct 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483195; cv=none; b=Mux22zbc8GTlMwWZ7kIhQOipApH33sqa+KR2hl9xLNhJhZW6dTeuYBlPHnN8xHFRJul1egzErCfaPRNM61vmMLKsJ0Tk8GDkhLRW7PPyIZOfkvnM50faXwt3PcoIQAvSdKrPgjFJHzXTVnrGDhG5VLhJACe9icJAQ710pIxXJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483195; c=relaxed/simple;
	bh=5VaBpTl8s7O6S75KrCduX+TKh7MjTSYhAeML2n2KwDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH/cAs6K4lsKIaeyS7IWagHjYmvakxEXBshGLgieADcZZPFtibrhre5v+QzhxaVTv6V9Ob6Q3r92mddn18Y6yMrO8eqvhTGJYPP4gx4C/ys2nK9bP5nYOPXmfd6HMYfuUi36CL7YO/bc21lE7A8ZWlA5kHSc1pI9LzPavh14TfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ledIG4vp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c593d6b1cso17595925ad.0;
        Wed, 09 Oct 2024 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728483194; x=1729087994; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1mJ9IhXj+vc15TnvWcnrarKm7uwlQx+nJ+OtHHPpLTU=;
        b=ledIG4vpju6SCxUlmSZheUsoz4rE1ILGPkGNNj2rvvF+dTMsXDD31ANA5zHUfZXG6F
         Om1SdfVhc9lWAzaxXVXn9huypqEXrpHhtf2CY/Thi+UAmSvHqGW7x1Oc9SkxLbkoQLNm
         TwVNLjzZiuezO2tet0JtnYqJeJRaz9o9pavibyItxjXapeRDEU1IVWjwHb+QoYexcynu
         hX5kjDgJtV6bLHtQkLMnUh1Qo3YYu4lyJfXQRIdimrhwy3XYyaJfbbY11j8ebE1obOef
         2xYz949wHL2612hULrfCzgbV5lhzc9S5DjSmPE3x0g/uhElB/nhtsvUFhDy5HPgLDJ/x
         MliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728483194; x=1729087994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mJ9IhXj+vc15TnvWcnrarKm7uwlQx+nJ+OtHHPpLTU=;
        b=o94Svu1CQyyAe1E0+V4uSnVp+wmEca8C8gDSG/NkqgVOFPmcQCgcWj6NA5/WxHES+L
         IaDunc2EzpN7kdcjinS5iu30hzKL9DfRhYglh9S+x4HbzAzcNQAFqIAn2zI/giwXdVQM
         gK6zwJXp3Og2LwRdhPjz5RavBbsKPxG3l4dK6mbVRQ9hDx0mRUeVUm5EqkWl+t/4AfgD
         NPemTXdK/nP5JPyzVjeX3tLnMvt+hvlPZkDrD8JNIRozeWEhk+2Z6pcOzCdJ+PAUgSoH
         8YI+RIifD2WRWOEgrZbhXIocak3c0gcX01bNt5VtX7ai8Uixru2ATXR7BdK/ZI+N0k1i
         mUYw==
X-Forwarded-Encrypted: i=1; AJvYcCUumR+cXu/JNpf5FkS0etlxG/RmNWbLlzFyDidlQL/69JyMC4ZE84DCom3qfOlcYDb3Hh8hbitoONutHr+6@vger.kernel.org, AJvYcCW5kMme11o5M8iyrbdnBSej64CdKQQGYg/FklSSldCnfQn6lcLfQDRBXpMdWOaodQK/MW3v1sDj@vger.kernel.org
X-Gm-Message-State: AOJu0YyYybRumS9viIaJpGghNKwbHtBZGTkH93Fue0j4Cubi0k4XiK9o
	vXfOZN3c3JHISiyh8nnm3YLsyL9i6vPFaNLr6nEGD+3p+Ekry0Dh
X-Google-Smtp-Source: AGHT+IFqQ1MJsErEHXe+a7P65I5Oe96H2ckzg2/xkoxKufQtn1j7d0DyvE/1jQp4DovOObK56Hiz7Q==
X-Received: by 2002:a17:903:187:b0:20b:b0ab:4fc3 with SMTP id d9443c01a7336-20c6378d269mr39498365ad.49.1728483193796;
        Wed, 09 Oct 2024 07:13:13 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c76a2202fsm6202445ad.115.2024.10.09.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:13:13 -0700 (PDT)
Date: Wed, 9 Oct 2024 22:13:09 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: xavier_qy@163.com, longman@redhat.com, lizefan.x@bytedance.com,
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Enhance union-find with KUnit tests and
 optimization improvements
Message-ID: <ZwaPdSOMWQzuoPWU@visitorckw-System-Product-Name>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <ZwZIXxQLyJUL_nOW@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwZIXxQLyJUL_nOW@infradead.org>

On Wed, Oct 09, 2024 at 02:09:51AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
> > This patch series adds KUnit tests for the union-find implementation
> > and optimizes the path compression in the uf_find() function to achieve
> > a lower tree height and improved efficiency. Additionally, it modifies
> > uf_union() to return a boolean value indicating whether a merge
> > occurred, enhancing the process of calculating the number of groups in
> > the cgroup cpuset.
> 
> Given that this fairly special union find code is obly used in the
> cpuset code, please move the code there rather adding more exports.
> Even as-is it is bloating every kernel build even without cgroups
> for no good reason.
>
I noticed that it was Michal who originally suggested putting the
union-find code to lib/ in an earlier email thread [1]. Before I send a v3
patch moving it to cpuset, I'd like to hear Michal, Tejun, and Waiman’s
thoughts on this change.

[1]: https://lore.kernel.org/lkml/wu4m2m5igc752s5vrmtsnd7ekaq6opeqdtrzegs7oxlwgypdcx@qhcnow5txxiv/

Regards,
Kuan-Wei

