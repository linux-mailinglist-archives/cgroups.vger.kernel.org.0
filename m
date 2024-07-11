Return-Path: <cgroups+bounces-3628-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83092EDAA
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9B6282B75
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194716D9BC;
	Thu, 11 Jul 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBWQ7QS6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B376034;
	Thu, 11 Jul 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718571; cv=none; b=PfxTkWNtPl+Jf2UIHnKsThCHb1/fTjp7OKkorEspHH3e7p8iXbMUgpi2I0a1e1e8RgZVlM4HsU6dScJE8b8gC153/09MAFJBA2gnFj3Nokrg3d0NrK9HZlhhm6cFdsTy9QbwBwFMArYG1Umn6jag+dThPwfGnruU0ldQ9zP87eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718571; c=relaxed/simple;
	bh=ylz6cggfOpRuz9Qcul7Vp0VF95Zbtrmf98WIZ9Qze/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzxZLtZLVRl7GcLa+9r5X2vlLDaneG5ELUHMm3qT77mQaWqvGt5D801qNr0g9lxGS6UmM/6lhdQBlNbEGWiU9M7T3Wh/mmcQadTknOp+InIzs23qSj2Dvri1NnjoIRLSluDTvCRUA7cj31w99YYL6V+KfyiVb5lPvCSwOdzfnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBWQ7QS6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9de13d6baso8891815ad.2;
        Thu, 11 Jul 2024 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720718569; x=1721323369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IaLncTOGjmwTWT1X4gzEXzozHzEON0/53jUKbxMYSs=;
        b=ZBWQ7QS6y6JfzMll3mfkRSd7ktZRSEeg04khChONufesrzzNFZDfL0P1OYOI5kHAAb
         y/ZxF6yUyv2Zb7MEW0xqi3itUu1glpyBqRgU2wwGyUUmuO/1O8+ClgQLCGZHAUfjcHcP
         spHU5gREsHZUpiPUc1NDYYIs5OUnlzW518hUnaT2Q9AdETSWMERl7KyZ/MXwlCXrlHds
         WhLkrn5P+cBbOR5N3imeW22SL44iblc4s/+ksDl+wnPu0qmmVpcaCxQm3787kFAdX25n
         dtex1lU3mkeWUxAPbU5rG2bJFY04SKUBIFeB5ieNZ883Yy8oro3OTwwq+KhFV03DDszp
         GnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720718569; x=1721323369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IaLncTOGjmwTWT1X4gzEXzozHzEON0/53jUKbxMYSs=;
        b=EgYFl/56LzuGIcAWqrFNVamVfkiLW8FT1WtcYRltpxz81PaqZ6jcCCeL2a5RMOCjR6
         0ttbUu8gDlH1PA0SBNke4U+hE/gaGGEfvqcUp1AbQgPMIRunc+1yOUwbFKlNrvVU9x9v
         i29weeBUHpptZppXrHLL+DJBLD6+dcKNlnEcX6zO5sIsTFXC4ozPL1/dzX24h8YnECjP
         z4BES3uX8aQBY5c253VwizuLRnAaZnCpOALEETgGFWoFR0U8ItqVlGWU4gE6MULvlC35
         n0gwA2TH7Bvie9Jr38qCl9uf7Iq7PBtpXKl1zxADEtLlottNslRIEBoNeuimzTUAUgTv
         Wc/w==
X-Forwarded-Encrypted: i=1; AJvYcCUW52Mm7EmPFcW4Fuk7wELJrDqWMPX9a9lnqkZis2hxgfWtJyhve2lQ8kXiztZDGWl48z60baLxaE66bfbzfPC+iZD7Qxy/Nh4zAIvJQms74vLugwFwxkf074RFa6uZm/oOZpjro5u37NXxhpKLlUtMpc3bUItiASbefHHcJuzX8A==
X-Gm-Message-State: AOJu0YwQ+FdHke7dm+y8CfYEvJ8CUHr9ibCsG/CDeMB80rAVTMSJw7LB
	RFgjqkeSvcyO1uQNouMUVVv8QrL4T3n2P3wGlnv513YCDZ4RXFLN
X-Google-Smtp-Source: AGHT+IHM1wxXd+NP1OkAb0r98W03jR60gU6aD/b01Go3/c23FC2DdNF1XJTBxd+aJnZphqhUPedRJQ==
X-Received: by 2002:a17:903:1205:b0:1f7:42ba:5b1e with SMTP id d9443c01a7336-1fbb6ce124dmr77081205ad.17.1720718569560;
        Thu, 11 Jul 2024 10:22:49 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad3460sm52904695ad.295.2024.07.11.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 10:22:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 07:22:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	haitao.huang@linux.intel.com, rdunlap@infradead.org,
	kamalesh.babulal@oracle.com, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/misc: Introduce misc.events.local
Message-ID: <ZpAU5ty2QiPXV_nf@slm.duckdns.org>
References: <20240711101457.2963104-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711101457.2963104-1-xiujianfeng@huawei.com>

On Thu, Jul 11, 2024 at 10:14:57AM +0000, Xiu Jianfeng wrote:
> Currently the event counting provided by misc.events is hierarchical,
> it's not practical if user is only concerned with events of a
> specified cgroup. Therefore, introduce misc.events.local collect events
> specific to the given cgroup.
> 
> This is analogous to memory.events.local and pids.events.local.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

