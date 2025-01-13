Return-Path: <cgroups+bounces-6107-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7335A0BA49
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 15:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920A5188491D
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0873720F089;
	Mon, 13 Jan 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WimVseVs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31A23A0E6
	for <cgroups@vger.kernel.org>; Mon, 13 Jan 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779659; cv=none; b=IoNaWk06eQS6jcI6E2PWGMnSd4+wIHQa9kUg44yP+RFweE6hYsxc+OzEAr2YkqxmHsfLFt4CmErloFCtgHNVt70f4zea/o9ZhXbDwPnw0D09cZUy4nBq85O6bvBG5A9pfxnTRP4ivZGQw0kUr3k2zapxk2g7DCAkisa2GW2062Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779659; c=relaxed/simple;
	bh=p0BXD1cDpGkYrf+027N1x1VbIUDOfys+SPBpQckVTHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GGdOewmFw7gzBXUCFEaMpaSVwEJWN8iOmqF1CgPes8jrxUdfWnFtVjlKO+L09sX3UyxYfUIjj94mqe3KMX4ISOemiphdbFjRHgmO1pJSpagcvrd1sa+6GyFID3SLO/SvXyZHEZ3TOlKgqdwR5fU4ha7/4USbe+HvkDoFSyGzi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WimVseVs; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844ce213af6so146158739f.1
        for <cgroups@vger.kernel.org>; Mon, 13 Jan 2025 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736779657; x=1737384457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUvOyHS2pnkd3Ntgdf/L4chMotMUTDYlGPzi1HeruzM=;
        b=WimVseVsy6vNKsi6RB67d7OrlNFJUxbpsOqGJIGwT05sMlSsMETQCtjN391RNNbmlp
         uXWzidEtV7Xjcuhymkfqqp5KZ4sgL+WVNRDHrkhedPOo+0ZG4k3mF6pfNIICuAnDHgGc
         9ml4g9CPdVhFOj5c2CQs26QqoVJKtKIc1qvCU3hcFPXpT39ASoB71oznyeVAU5BhAgES
         yQGWHhMlRUsbs9y0MiB6Ufb7qXMqMt5N/iJjmAzSumDYaGCf91TXfd3ysak2TsDVvVT4
         u13aFqGTEIxbtD5z0k36XGY9b0fTEctqWo5z/nqW5Y0PvknoxZfik89xtx8QmVKlKeD4
         BeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779657; x=1737384457;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUvOyHS2pnkd3Ntgdf/L4chMotMUTDYlGPzi1HeruzM=;
        b=pCKBCp0bCOSQO7+t4RhybV9JksFfWRwK8AoflJ5uYACmHY46zmj9bN6yxCLY6BfidQ
         bXiy6/KAybUZjbL/xbp3TTs+9it2pz3igz10+UvQPUbSgAdHQIW6I/h4wjsNUEGMiT5h
         nb6sgeOi5Sx4DWT82G5IbMKbnXm3mMEPu0z76pvTmjGcLRklrKMdnGxl/NXHBWO9sUZr
         tgua5G+sg09reVr7pxFKeafsUxxZAT/WyWdzZx4cg2QjxcQLZNGOS2o/UTVL4I0YCUZs
         4UMDW1yO5xpDqomeXrVO0VBAKQr7EBozFxjjZ/xIxeSijm0wDNiUw3gCu2j3tMMQKXEI
         A9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW6uawSZJjy9gEMqcUXk/98VFL+HaqsVYEHeDb5EOVaoyAr48Mjoi7AlrsbX3PhQIv9xDLceud@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7AaPbMVrrJdqujGVIh0GaS/7PXnj65Ol3HmnXnqcHWW5EFVys
	cSDCGvUGIdM2Bt3lUTx+ZIxkEXkTMbrXLSaO/+/rGns4zm2kxk3CUD0bOuC1IKs=
X-Gm-Gg: ASbGncuRgt/ZCJoH+hByCWdBAJh4ur4+e4cS8E1VqefYwhzfzvvaIgpf/8g7geq7L71
	iI/0I2nhnQG3y+RzZ/grP1M4Z7+5Tu/5jTREXURjSEAXxqrW4VR8ipZpsjNeK0Qe7W2izgAaCBt
	it4GeZIWfbMeOAOmAFi5sA3Zzks43myV0rIktoAyox+rErGn6qNXnEDynJwDJ4eg/n63aoR1nQD
	ggJ3hLBIB2/i4JQrn6jKAF2nwzMG63iK0+jShTrZ88gwk8=
X-Google-Smtp-Source: AGHT+IELFBX2GUIlb67NreyyDTsoPhjczmus0/8OGSWz1WzZnOmyMqhnn3ZIOEmxmdQnJqW3qfAUug==
X-Received: by 2002:a05:6e02:12ef:b0:3a7:8720:9de5 with SMTP id e9e14a558f8ab-3ce3a9a50b3mr149381185ab.1.1736779657277;
        Mon, 13 Jan 2025 06:47:37 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7459e9sm2768810173.118.2025.01.13.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:47:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org
In-Reply-To: <20250111062736.910383-1-rdunlap@infradead.org>
References: <20250111062736.910383-1-rdunlap@infradead.org>
Subject: Re: [PATCH] blk-cgroup: fix kernel-doc warnings in header file
Message-Id: <173677965645.1125204.5023386216499075491.b4-ty@kernel.dk>
Date: Mon, 13 Jan 2025 07:47:36 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 10 Jan 2025 22:27:36 -0800, Randy Dunlap wrote:
> Correct the function parameters and function names to eliminate
> kernel-doc warnings:
> 
> blk-cgroup.h:238: warning: Function parameter or struct member 'bio' not described in 'bio_issue_as_root_blkg'
> blk-cgroup.h:248: warning: bad line:
> blk-cgroup.h:279: warning: expecting prototype for blkg_to_pdata(). Prototype was for blkg_to_pd() instead
> blk-cgroup.h:296: warning: expecting prototype for pdata_to_blkg(). Prototype was for pd_to_blkg() instead
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix kernel-doc warnings in header file
      commit: 4fa5c37012d71f6a39c4286ffabb9466f1728ba3

Best regards,
-- 
Jens Axboe




