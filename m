Return-Path: <cgroups+bounces-3653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F192FC37
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53F41F2380D
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643622AE7F;
	Fri, 12 Jul 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TduSLJkj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F0125D6
	for <cgroups@vger.kernel.org>; Fri, 12 Jul 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793270; cv=none; b=hlkWtir7cXnLXjpjkmkx8VpBmBGO7c3DrsX9Hk1xXHZf2HcOAJLbx2pxJned+VuRZNnNqcrbb7sx1TH1DJhTUGU6SiqyHPm2YF0+TsTrQbWIeA22VblBPRAqn0sUdNy+YlMCEF6kS4N8kWT+ZVhgm2Iqcs2R6e9JDHSWw6jHC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793270; c=relaxed/simple;
	bh=WP9+jhhAk4DAT4I1KGSBxiIpJjo5Dieve8zMcvtSFA4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g41rkT+ymJIZTgtJVfk0fvhHww3idRo2U/Pbu3QJrtuhpzbqWZAj7x8ecVWGoFdffNVWhHU41VGfXQrAKteFrDgJwTxoAj2feEGgG6cqCq1SxCOBskN3uOU70CDUADZIc2L7PccKt7chCD/tdAZuhyZGoEjYxqsJrmzPzBjnM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TduSLJkj; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25e15406855so1257368fac.0
        for <cgroups@vger.kernel.org>; Fri, 12 Jul 2024 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793268; x=1721398068; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMz5esgrJwRK312e1WTAVR0V8yFfJbUzbMXMmXGeVCY=;
        b=TduSLJkjUPSRKNWG/aI5ae+jGFWiJt9D3WpEDEZ7+Z/WMtJOk8qXEuSPhvyuhnTpgE
         sB1XLJ5xW7H1LokAcGgF6mHTPnu0hH0JbSfT7M0rlRdQ8Lj82ITZperGA4gsw6qjIjiy
         /yW+RAtDqy46qqZMzQqxQ7EaiYW8dn8N0Swr6m81tsIMlVIjEJqk2ZiX/1RT3FeqIWoi
         xw2WTLwqOLzxf9d3kWZDf6J5blk5cubZqhWwvzpiwIzKf/ByxHQ54Owh5waLi6CJ6uf4
         lDRevo70K0AM5UjuPJdVMCX81x3+DBb0hFll3T/Q4OMF/U1tYaYrdwALfiRseZykW6d0
         FGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793268; x=1721398068;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMz5esgrJwRK312e1WTAVR0V8yFfJbUzbMXMmXGeVCY=;
        b=mhj+HIVZKO/TclKiN+XK9fb1uejaZOIRqJiQNbO5+xsnnAERyqVC0dLnVU6YCM/8v4
         yi/U0TccI+VzrzaaXDgOiutIBEp34SSjy/lfa91OpxZk0r2+vlIVDgPVSi/vv98YLwQb
         TYJeRi4h87mB1TpwljThgWniXNfLKn4DGIK+VhnqqUViUviLAQQ6lYq2tUS2R0sDo7Ck
         eohnrFc6SCSG+ZrlIsN2Nyc4SJRAQvUuhAWaB8Sf7bhDdG0jdk70sKGtzJLOsINkTo/8
         HW42vXAE9w3t+UrK7Z3f9Cxxn88GXDhzjlnsCx7BRH44eV8xFNGIlLbO3xSJEMeRIx4Q
         1Zng==
X-Gm-Message-State: AOJu0YwQ7ZPxuJnXJUZJeY5oKd23UtqZxZXbdm66sIne+SO7eehJb9u4
	cE5k2jjTo3UdyrZHmExA0BhYmCL8jAyotx1BdNp2A6RGa7p/h78r+lbYV/qX6jg=
X-Google-Smtp-Source: AGHT+IHYeX+/ZRC8RaXHpULyESMPrY1Z12YIoV5KaKKdiLCsnoMLvH4/3lWpXG2Enb/qvlRZNZYYwA==
X-Received: by 2002:a05:6870:fb8d:b0:25e:247:3ae7 with SMTP id 586e51a60fabf-25eae88aa88mr10200178fac.34.1720793267862;
        Fri, 12 Jul 2024 07:07:47 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa3106e6sm2189998fac.58.2024.07.12.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:07:47 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:07:45 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: cgroups@vger.kernel.org
Subject: [bug report] mm: memcg: move charge migration code to memcontrol-v1.c
Message-ID: <cf6a89aa-449b-4dad-a1a4-40c56a40d258@stanley.mountain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Roman Gushchin,

Commit e548ad4a7cbf ("mm: memcg: move charge migration code to
memcontrol-v1.c") from Jun 24, 2024 (linux-next), leads to the
following Smatch static checker warning:

	mm/memcontrol-v1.c:609 mem_cgroup_move_charge_write()
	warn: was expecting a 64 bit value instead of '~(1 | 2)'

mm/memcontrol-v1.c
    599 #ifdef CONFIG_MMU
    600 static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
    601                                  struct cftype *cft, u64 val)
    602 {
    603         struct mem_cgroup *memcg = mem_cgroup_from_css(css);
    604 
    605         pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. "
    606                      "Please report your usecase to linux-mm@kvack.org if you "
    607                      "depend on this functionality.\n");
    608 
--> 609         if (val & ~MOVE_MASK)

val is a u64 and MOVE_MASK is a u32.  This only checks if something in the low
32 bits is set and it ignores the high 32 bits.

    610                 return -EINVAL;
    611 
    612         /*
    613          * No kind of locking is needed in here, because ->can_attach() will
    614          * check this value once in the beginning of the process, and then carry
    615          * on with stale data. This means that changes to this value will only
    616          * affect task migrations starting after the change.
    617          */
    618         memcg->move_charge_at_immigrate = val;
    619         return 0;
    620 }

regards,
dan carpenter

