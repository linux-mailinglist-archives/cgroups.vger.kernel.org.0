Return-Path: <cgroups+bounces-3552-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A812928D8F
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 20:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB01282581
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9B169AD0;
	Fri,  5 Jul 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMpSRWpa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C8225AE;
	Fri,  5 Jul 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720204396; cv=none; b=YlSp/Lh0h59LYL4/epOj5e4JL8EwmvIUgM6qjjb3QfO/t3sZAstDAfmKNVciFfxuTvo7d+R6FAJS2mq48lHX8g4+EHV7pWGnQt2X3YoneJL8nRlJ9CnykFNx4WB3Y2faUJm1hQi1kd1PAxylaAjkScwaf2NLs6rB3O7obv2A6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720204396; c=relaxed/simple;
	bh=ZJVpS3eTCYHPlanUuEV6FHfgPUA4HZshmIRT/LJbahU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRlfMysY4jbngUeNLpXVPF57GjmglrMNguYY/4AACKUp6CJZ/oz2tlxhQZa+69sA/fHCgS7P/ozUhIC9nFpSiiNSHwb0IRuehWOWfiJuL2m+hFCuNoo53giTI3qHpS08Bw9Ooy4FmyAkjwXnNK8aM574JOZUTwVSpbUuN3yB6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMpSRWpa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb4a332622so6141415ad.2;
        Fri, 05 Jul 2024 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720204394; x=1720809194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brZpNyF6HgASJsElFndUGdwTOe58aOIX7QAQUfe35iY=;
        b=DMpSRWpagJ9gbDOPDvj6AEFypO8WVaNMdI7tfexHnH7O6Kf3ep76bjQ5/DGJWit7e4
         6yOAWU2TNtyqC4zUkX3VfnvMRU4wFpxI1d9DskxoJiwKhyww8KdB9DOCmI8mWv2Eub/N
         gN5KC/pIRdXj6q7DRIv8VyUfyeRi5yDtNEkjACqXY8rc3DJhnBabMioWUUb0rBNkoNTj
         HkX5dCg69GrvLjTFK/2KqhAer4fRtpNtd1mVs7JKUpnQo+UujQtsEv1Qpqs2MHflf0u3
         dmr1tGhsgpml3f5hnYgKbBazGxUSoBst7ENWZlPbMkArApgMNeRPOdiPIj4yPoSyiTyM
         vNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720204394; x=1720809194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brZpNyF6HgASJsElFndUGdwTOe58aOIX7QAQUfe35iY=;
        b=KnEHxU6b7j42SrvGiBkXE7CBytavb2tS9AyFjRMMJ34Tzi3+LznYrO0udwPLT0HkDo
         UmdJYQL+tnB1Nd0ZytdgoFVDgrQZa+X6VrXzEwaFsVXtLUeLeMLSr/Rf6U5PlXHI9mWN
         fc5XuEQkAoynBKCsjR48dfxgPZAo37oFXqYxTu/nBdBJvv1Tf2gVuOFzxK9M3wel9UP6
         0L34lNQUMBN3hULDbhYe7RJdxbd6xm1i0tXXOq8jtzMrDaKdwB6IdR1cnwCRa7glTNa9
         IRLBIhqe2SShDdsnluA57KnCnCF6H0/rwVk8jpgFlG/pyvG1NbZnM9iCdLcHTCpr8QEU
         E7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXUfeVqV3EyfExBJTYByg94rOS89wktxpmNbD42He2V4mGBuCrAnSqen0DeWGvCueZZZ8AVd+1BBwzKHsTBnQHtOwyiblyo/F/MKuNZkuYsD3TkBsUYtwFQoiiTExuMB7wks3lduQ==
X-Gm-Message-State: AOJu0YyBl2UE2uA0ywBdxLDlcgBKpQKciHZX9b1G795I+mj24zLs3D5l
	HUxH9n9e5hoqxqjFwBGrIcr393DEzc32GaxYw00Lo1NaQ1tRvRG8
X-Google-Smtp-Source: AGHT+IFiwsw8aGWhG4oepNtiCh/TzP7BuWR7b/iV6umlvNBDzxYen6db6Z9UF4SoCKJtZ4CG8yQFhA==
X-Received: by 2002:a17:902:f605:b0:1fb:358a:2f65 with SMTP id d9443c01a7336-1fb358a32a0mr38147625ad.37.1720204394550;
        Fri, 05 Jul 2024 11:33:14 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1e6db215sm50278865ad.164.2024.07.05.11.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 11:33:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 5 Jul 2024 08:33:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 -next] cgroup/rstat: add force idle show helper
Message-ID: <Zog8aHU7s2CrrkXF@slm.duckdns.org>
References: <20240704140119.1423196-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704140119.1423196-1-chenridong@huawei.com>

On Thu, Jul 04, 2024 at 02:01:19PM +0000, Chen Ridong wrote:
> In the function cgroup_base_stat_cputime_show, there are five
> instances of #ifdef, which makes the code not concise.
> To address this, add the function cgroup_force_idle_show
> to make the code more succinct.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

