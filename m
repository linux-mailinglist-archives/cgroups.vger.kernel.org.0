Return-Path: <cgroups+bounces-3749-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007BA934278
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 20:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00121F229F2
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF41822D7;
	Wed, 17 Jul 2024 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhC9osbf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6677470;
	Wed, 17 Jul 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242628; cv=none; b=d/9EgneJl0Tx7OFhRZUF6db19rHehcIvWrDnB4L5TjSNPEqQ72zhJg1UuOhXUTSnLkat1+rI/RIU7ghIHlIdcEzcq2Imb2NDHDHaoWRs0ETSDB5ovQnsQzebTJdPiDxMqtEq6DPrpKbMApo15iOcCOf0RJElWQtuzrWt8jsz2UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242628; c=relaxed/simple;
	bh=nlGu9ATzmRDZuQG1S8SgP+DAxKYsS8oizcEo/kGejXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWgiCKHiJ63ET40BkpHVEkOrG9ISusd3FU+yo+1GF9G5HsMcovVPoc7vJNrSGM0CZ8DE3xijwUBd2Wk2dSNUCMqowt396OBkvD+RcOlzJwupcgVW9Rkk3nWU0stTOAyXgLDlFIpxlkQ7TG6GMzMFWLSkwGYFpX2AVEW2Y+xEtB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhC9osbf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b5117ae06so5138372b3a.2;
        Wed, 17 Jul 2024 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721242626; x=1721847426; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JL/3fZ/KL80SbG0gxIevxprQw4yP8Zt7WBtlleXdZVg=;
        b=LhC9osbfMAktn0MJ18LXAUTq6r6Yvi1Ed8t0xmSY0r9bDU72sk8K5T9NLRxMBqgQcg
         DBeedfVv/ckMuhJa0VnepXzLDLoneuQ7zTiEuXqoo1UwFJmTU2Q3+UExUeBdDmcp7XQX
         3KhjF9f+MlO+DCafbUE6oy8IYj5E+XaK+1PzdLs/i5457in+2HXSn1G5oh7dHWqiWLbo
         o80MEeHm36ybpi7bjT1HNuZXRxiOdDuieSvI44FqF3BTZFH41V1bWTok3r56G2RLmfta
         UP95K1+vFpDt/YqBoheyoqXvBBUxu20zq4cXjnnJkx7UYg1mhNYqgmgHKh5rI7uqip0M
         ff5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721242626; x=1721847426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL/3fZ/KL80SbG0gxIevxprQw4yP8Zt7WBtlleXdZVg=;
        b=FAl4f2IeDmZ0wiA6i5lpCsQwO7PdqiPNEVJ+sVS+NkCMNuzFaWgODs4OK5l3a9/QKh
         TCyvQ4cTB1/L/H3rrsEPzgkQc8oXiL1P7ZDyoJoEIJaMXZt2wN6EYPQ68Q6VebmnupIQ
         fffYG9zro0WAOzT6yeD/SmZ/O4xM7u7HWEhilU2vL8Ig1I1RI7JtED7hKqLCxhofNufg
         caciX/yrL1+Rd3tFXlU6NvsYB9S3TZxHb1jHRpL3StePbLzq767JYfsP5AC23QvDItPq
         jUlVQUHwL7eyy8MR4cJtPbFl+2EGwK54adlZ0Huw3Rfxxq91t+wBhFpS6yPvqTL8YT0G
         KQAg==
X-Forwarded-Encrypted: i=1; AJvYcCUs+PoJZUMFclwwQB8WqseJzmyKFPkZ/s+bQaH7wgc6fUpMu7JkkhzuMc3L7doWD/ZVi4lYdB8yr0noSe01j8akehTkBHA4yq+D6qDr7EnEh6o9/4qfToTtpm3QFlCbIX44VVG9dSIzUhEaERHyaknwUItPKTVxPyGo8A7iwfivHciu
X-Gm-Message-State: AOJu0YzQPAJemkU8gmDCKNc8pI+kf21ZZW6WgKSgYS26NLd6OuNDwWrU
	AKMcTi+Sxwt3hIwA1TetnMEJQqbEjC3jcEeJzMOWYh0xxI6TBlWR
X-Google-Smtp-Source: AGHT+IH3DCORNRV66+DX2G4j/+aDcK3/wP21M12HIrSoFR/73qsZi0G8Yd6O/P2L+EWP1V3eBSr4Mw==
X-Received: by 2002:a05:6a21:9997:b0:1c2:1ed4:4f91 with SMTP id adf61e73a8af0-1c3fdd2bf9fmr3817008637.31.1721242626016;
        Wed, 17 Jul 2024 11:57:06 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc52bbcsm78305985ad.291.2024.07.17.11.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:57:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jul 2024 08:57:04 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>,
	"boris@bur.io" <boris@bur.io>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
Message-ID: <ZpgUAJn-ypO-0JZg@slm.duckdns.org>
References: <Zpbify32lel9J-5I@slm.duckdns.org>
 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
 <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
 <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
 <f448f66b-7a91-4281-8f77-159541cbacff@redhat.com>
 <ZpgB9kCAxAAXAtSi@slm.duckdns.org>
 <134fc34c-10b8-4d00-aaca-8285efce9899@redhat.com>
 <ZpgMajKn2O521H2s@slm.duckdns.org>
 <48fa8bc9-9f8d-4406-9137-88a555883ea2@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48fa8bc9-9f8d-4406-9137-88a555883ea2@redhat.com>

On Wed, Jul 17, 2024 at 02:55:37PM -0400, Waiman Long wrote:
> I was wrong about __blkcg_rstat_flush(). Right, the main updater of
> iostat_cpu is  blk_cgroup_bio_start(). We do need to drop down some comment
> on what is protected by u64_sync and what is by blkg_stat_lock though. It
> can be confusing.

Oh yeah, definitely. It is confusing.

-- 
tejun

