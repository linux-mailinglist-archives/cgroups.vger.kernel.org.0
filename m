Return-Path: <cgroups+bounces-1021-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3AA81DCB5
	for <lists+cgroups@lfdr.de>; Sun, 24 Dec 2023 22:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF7E1C21473
	for <lists+cgroups@lfdr.de>; Sun, 24 Dec 2023 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E16FBEE;
	Sun, 24 Dec 2023 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzIiXA8j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641F1095A
	for <cgroups@vger.kernel.org>; Sun, 24 Dec 2023 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3600101e819so19115ab.0
        for <cgroups@vger.kernel.org>; Sun, 24 Dec 2023 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703454029; x=1704058829; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ze3dFp7nuwLIlYyxkNcxvwY2+LEPIxqYIZFYJMGB88=;
        b=uzIiXA8j+coQx6Ees+GO/RyGbmnaHqEwJD0c0K3EOUgr0wLrNk8HRQXqT5pb2/bqGH
         iBBFH1WK6aYtwVNbtMSFT8iE293o/+b2vtqC99m3Frm8xs0gk9Ttd5A8tc/4yPlTLTD4
         AXQ5Xwc9zrUE6cWhm+Wg+rtTGCYQCsQaqPSIDrTRy/5dmTygy4JcsPvqk9SODtElfe2d
         8s/k8DJVOIxsgiOWC2LJX97oovXTbz/Rk8xHhGBz+ywaYOIcReIeX1uXwkH8e/zJjZjX
         aL/yINrYZ8CjkXI43q18AFO8UVqq6dkv2t4j1eDThVudSYOd0AcNYJ3K7MnmroeAlL+7
         iqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703454029; x=1704058829;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ze3dFp7nuwLIlYyxkNcxvwY2+LEPIxqYIZFYJMGB88=;
        b=hOIksegVrSbxp+/YQNwBFgy09lRVxrD6bSt8vKucUa8HBaZcioC5y/+1GVGDKMjCdV
         CyJKfNSEdCj9mbaPNneGNmdtJjurWwyk8anvQ4+ar8mCFFNbC1fExiW7p+P5NYk62BbP
         NiCgzlB7LOh1vfSAfo9EnbYLUbiMLg9S6lOzBX9EdeKfa0oz8w7Vo+r+eG2ofZypd2GH
         tIstDgrSfJI/Tz8Xz3grrYuYxp/bHVBl5Pg/XhH6Q8N8puonBvUBCgSF9orP6Fw/E6mk
         eVExxZg0n/4K3W5QxyvTc9se97ji9MY+S45bxuqWkstQu4mj/aHx3Vf25/BTSHgqqB+0
         DO+Q==
X-Gm-Message-State: AOJu0YxrAXUN0d+O0cvm4s5rqCBMAjEzfn6SAjcBn6VCQSeN9ZLsPIQc
	okeGWo5joiAeaZx0xX1HXofFYsDp1AJE
X-Google-Smtp-Source: AGHT+IGVjH+txTkfFSMsBbhv6Zq0xwdPACuwyfbDHigrPlypESjKlpkGed7PeZwM+hfx5XjzT8YDrA==
X-Received: by 2002:a05:6e02:492:b0:35f:addf:c08e with SMTP id b18-20020a056e02049200b0035faddfc08emr371465ils.19.1703454028683;
        Sun, 24 Dec 2023 13:40:28 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id w22-20020a634756000000b005cd945c0399sm6737737pgk.80.2023.12.24.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:40:27 -0800 (PST)
Date: Sun, 24 Dec 2023 13:40:27 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
    asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
    cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
    dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
    iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
    joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
    linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
    linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
    mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
    rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
    suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
    thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
    vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 08/10] iommu/tegra-smmu: use page allocation function
 provided by iommu-pages.h
In-Reply-To: <20231130201504.2322355-9-pasha.tatashin@soleen.com>
Message-ID: <2b7e2912-4be7-4b24-ee56-0378a3ac1d3d@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-9-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Convert iommu/tegra-smmu.c to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

