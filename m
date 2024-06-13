Return-Path: <cgroups+bounces-3183-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2A6907EE2
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 00:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6EA1C220FF
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2243B149DFA;
	Thu, 13 Jun 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCKChL0a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152F2F50;
	Thu, 13 Jun 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317927; cv=none; b=UZUR9YoB6Sr+qrvjERA1h9Y7SH9o2vyCwVLGL9x0Oo6sIOm+nOkfhfBwwD+7uxuvClbdR1WUQkxBRaQfg+Dm992z/YNaf2vWweT5DmF9f69/K+jJEXucmyWNXX8EmoIhvXnzfaN1o7vPc+73HKEEJHLWUX6+6l0jJiiAwhmiH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317927; c=relaxed/simple;
	bh=qPSXquU6U27MoLTDYbXSvkIqxPRvwgayXwThhzfL44Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzR3wiWNsmyVscD2lbQYaP8Aa1AU1ml4umy/iMCU7FDtxWjcJLK/V3Cer/k8XxCQuRU6BYHGoOWef+l0J7Wk88ikWIR7dqNPadGsjO5T9VR7n5DcdiIVanB26MWDZJm3+0NWq855ot6cXHUfAiBGloUjR1Nk0NMVAerGZNhG4cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCKChL0a; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70436ac8882so1249962b3a.2;
        Thu, 13 Jun 2024 15:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718317926; x=1718922726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdBrPdC03uBfyp4h0UDLcnfRIq5hLrsMUcQxR+uWGTY=;
        b=jCKChL0az7IqMz9I1v6YwIpNeom8QE/14gKEqL+2ghNqIIgHMT7haco7QjmhBCE59P
         BBln8th0catKdZOUcnKrbqs6nXF4G4007bwn7d8CnBbI+cBlVe+a2MZPRIiQUfxVvIDv
         VpruTiFXg6uZmavcOEuCZWXwefWgh60pE2Sh0ukMH0+W17GfmmFNkJon1ORYfnQTlE9z
         v0CZtFU4tyjFe3Pq6BkJmf4QPS2lVYm6xctqFKnG2UGa1deM/edH7I58rf6aB8EdtttX
         d/u4fFjMRCXcPqwWt3A8L76rViYd5IfyabPE29oJKZvydpaigVpRN0YUg1DGvWUKapYy
         OhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718317926; x=1718922726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdBrPdC03uBfyp4h0UDLcnfRIq5hLrsMUcQxR+uWGTY=;
        b=v6tP+aaQ1AcHqbKEZXpNeJ88R54wb2SL8o9mMx+Mc1z4eoKftRpubJVrTDowRWyiUx
         WvkMuI5VUiA566rL2JTFb7llFFarjP+eFNDUyXvLNCqKe5ZrbSIejTsyBPQNJPjBPWYK
         alpZZal5wh/djPe/nbfsssWyTjKrpX43IbcWXjSrcRfB6VwDkjPOV7VrPbVDjLLqJDJP
         gD0IR4jF53lNSu33pCA1AueBn9Dis3JLF2seh4n08nMUAljx4EH0+iyEa5oXKMrq8ZVt
         g4c7tFzEvBneOJy++cTXyzbUSYQhht9h/wJJVvLwZlVv6EMNgB6uWvHgp6RIqi7uAOHQ
         rv/w==
X-Forwarded-Encrypted: i=1; AJvYcCWS178zbxd3Kiuob3olvGfDUfbDEgddJI6T/BFCivzwOKKMKeMKHeKGfW51wFUXuHIDhOWeUqkgMs8nESSENOc06stdHkHHm1H37n4dqOt5CmHQPKCCpxRv2dsMz8r5NTPsVyenxSoolaZpdEhmYw5qlyK5SUVu+WzkuvyKaw3/CQLC
X-Gm-Message-State: AOJu0YyD4KetVp+Gr9pTFTyiNV2JqZn5bPGlbJqWpBBqOIwicHxHR3/F
	6nqVA7a9fCbRBMWgnl9vbmS3/VpS2RmIL8Ysu+Io8hgM1N0HlqDMFQP6yw==
X-Google-Smtp-Source: AGHT+IHtcFkCRzKVUWoWnuA8d2ZTx4W7xmzb6xaoYGxgWDDH+MegbR44iI4dxtg/vsMxIbAMcFnCVg==
X-Received: by 2002:a62:be08:0:b0:705:a669:8acf with SMTP id d2e1a72fcca58-705d71d1277mr922095b3a.26.1718317925718;
        Thu, 13 Jun 2024 15:32:05 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3bf00sm1846190b3a.135.2024.06.13.15.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 15:32:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 13 Jun 2024 12:32:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 2/2] blk-throttle: fix lower control under super
 low iops limit
Message-ID: <ZmtzZKW1m6JpdfWx@slm.duckdns.org>
References: <20240513120848.2828797-1-yukuai1@huaweicloud.com>
 <20240513120848.2828797-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513120848.2828797-3-yukuai1@huaweicloud.com>

Hello,

On Mon, May 13, 2024 at 08:08:48PM +0800, Yu Kuai wrote:
...
> However, if limit is quite low, the result can be 0, then
> allowed IO in the slice is 0, this will cause missing dispatch and
> control will be lower than limit.
> 
> For example, set iops_limit to 5 with HD disk, and test will found that
> iops will be 3.

Hmm... can't this be solved by starting the next slice with the right
credit?

>  static unsigned int tg_throtl_slice(struct throtl_grp *tg, int rw)
>  {
> +	if (tg->throtl_slice[rw])
> +		return tg->throtl_slice[rw];
>  	return tg->td->throtl_slice;

Because this is a bit nasty. If we want to use difference throttling slices
for different cgroups, we might as well do it universally.

Thanks.

-- 
tejun

