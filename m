Return-Path: <cgroups+bounces-2944-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C18C7FA6
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 03:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358D928300B
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74417D2;
	Fri, 17 May 2024 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/mCq9Q4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308811392;
	Fri, 17 May 2024 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715910379; cv=none; b=MjPFR1s4ieNWL8yOwVQDh6FRZ/+ngoLTWci/EdglNWhs6SScc19gFVS/Pt7shSV1p9TMjVuGtIoc6ICkAHLeApM/o7OF7vlwcOGmtOln4hOCED4OtA21FaJvUigWtcwv32l4xwM84MUca5CTjyWX+XrTP1xcco5XuKi7w3gTw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715910379; c=relaxed/simple;
	bh=vvcK1hMFe6iSJsDzw33G6ep4aDId8ZCCmi38cPD3wMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuBikEXvpY1leGZ6wJ/IJDPyjg3+WAB4f5c/h50lD0yhoyAc+dtLrZjj/YJnVgm0uzXum+HwP9ImS72MhZaXdancQPMz2HM714Xz5YTW9RZSGB7rgGwvWRE/uShF2rmPKE5N+kQ4/ddMLTZIkP8aahNTR9USwXntt5uRUBeRBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/mCq9Q4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dca1efad59so666232a12.2;
        Thu, 16 May 2024 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715910377; x=1716515177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAM5I02x//m4bKLdD1etFangHl+LRDaBqmRKyVULTkg=;
        b=j/mCq9Q4q2PJSP6WTQdOoYlrMOvloi26mkHaAxyJ9I5NifCd+rTCwrLpTrcybHY3vV
         gB4k1SjpKiNpftuown9RyTFniX/7qML8Jh+3ckHOHNmbZFYpGIA9ejzNAq1ZTjIp01Jv
         B2OaES4fbMTEZwOG+Y8DAWbYGTdygf2pkdhz5P1aOAl9yYrA3/0F9cO8lIUk4+hvUWsi
         mNXIp/4tTxejoNM1rOMrfSoe0hiH9vjemifO24bbmCLk67obyxvOnQRfIxIB7Dra8qjH
         mEacIICRCmxtbiAV49NSO1+Pauxkodv/RB5NZA43xKq88Y7PwVYPbz7uWxTV4m+YAbJw
         w4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715910377; x=1716515177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAM5I02x//m4bKLdD1etFangHl+LRDaBqmRKyVULTkg=;
        b=BU2rGS01IpDnqbKfCSjDYcyt0GCZwuhHWK2+yKyt7Fn8WRJwTq6gjGBADVOigFZxNI
         cC5HwX2/ocP1ZUbUfdnzpkLiImXDmMFM1hXRGB8g7noQAz2K9accW3LcQi5+iw1M5Qkd
         QePjb8FWU+9asqhx93uxd+/hweMsjR065uF4KsgW/+FuYE5pmxM89IVlIEDhZPXMoFky
         FYiBPDa1HtbLc+/Z1ho2iw9VDZwMqlH1rKoVxKVhGfc/tVYMWrgOF4wyPiSblE+4lkoE
         a9PRiQ6z3uyeih3E4BCqRoC/ffMoJ7Xb+/vPrQLyMLJhfTGPPcUQ2lq7QoYT4uwxvWpR
         1KMg==
X-Forwarded-Encrypted: i=1; AJvYcCU8ENC0QzqR2awzElnqpy/P3nxTQBKLoFYPkRTlcj0+6yVOidNF/zVrHfNDBDnjNXx+Gj5lFj3qkpBZB1wtgIKskcB9VQJ8YvWYaBPswHroe+Ejk4yc3h7GZ9y23wBFqqxec7y/Dw==
X-Gm-Message-State: AOJu0YyA6cj5O0m5AINQxVx9/RPZ56E1LU94/EXupKLRQzmvzvcA+FKc
	3PK9eCKUNzBx8OK4+GigrfjEFF/vCKRE1kdYSzPR9jXV7j6v/BQf
X-Google-Smtp-Source: AGHT+IFHAF0w/wY3vX3B0isTkZDP9D6wPs+EbtOQKnspoKcHCebJu5+AwiC6XBL/9ObI4tNbqxA/iA==
X-Received: by 2002:a05:6a21:3391:b0:1af:59b9:e3ed with SMTP id adf61e73a8af0-1afde0a8d75mr22562767637.5.1715910377366;
        Thu, 16 May 2024 18:46:17 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6584e7897bdsm2548555a12.21.2024.05.16.18.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 18:46:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 16 May 2024 15:46:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, cyphar@cyphar.com
Subject: Re: [PATCH -next] cgroup/pids: remove pids_cancel_attach
Message-ID: <Zka2512X0A17eri9@slm.duckdns.org>
References: <20240517013001.215350-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517013001.215350-1-chenridong@huawei.com>

On Fri, May 17, 2024 at 01:30:01AM +0000, Chen Ridong wrote:
> In pids subsystem, pids_can_attach never returns an error.
> Therefore, pids_cancel_attach is unnecessary and is never called.
> As a result, it should be removed.

There are subsystems which can tho and if pids is being migrated together,
its cancel will be called.

Thanks.

-- 
tejun

