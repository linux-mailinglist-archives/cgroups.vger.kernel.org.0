Return-Path: <cgroups+bounces-502-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB747F337F
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B9A1C21C06
	for <lists+cgroups@lfdr.de>; Tue, 21 Nov 2023 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196365A0F6;
	Tue, 21 Nov 2023 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7zkyBPN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83478194;
	Tue, 21 Nov 2023 08:20:10 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso4994857b3a.1;
        Tue, 21 Nov 2023 08:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700583610; x=1701188410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fEN3R0r2mIA8xeTNMUf2/tu7fnJxweTIz/sq8uXz0Y=;
        b=C7zkyBPNKmwuqgdV6DlkAzWzyngAmAqomeDNGKsmvZB4+6MsbO/p8IMI5P9EQ59Tqq
         IVA9EKkJHFK1///SVIMHvmZ9C6SFgnKyRpAkp7QxnpBzCvYSKms0CeLWJvBucLeqDSJO
         uvgPqsVdWVlDuyfVll73UOnkMXSVGi9PN2FGn3kfFoLf+V6AyqW4fFoStfk1m4MVY5UJ
         AtG0cX4ue3vVV3boMuQ2WlXdp/p3/CNlPXRiud79cbW8x80lDRMN+qUfdPyDOlL6ImRm
         LyXAnssgTSkX/rnSk/2qoiUUpmm4oSdslj3BvvS9yUQh8CskWe69LtXnZPgx6tEW0NB/
         7IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583610; x=1701188410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fEN3R0r2mIA8xeTNMUf2/tu7fnJxweTIz/sq8uXz0Y=;
        b=GjAcM0Jrr6OzvzDaXTfIPayCuTx7kS0UGzPofyx0m7agrTn3tbeMqpX5HyqjEvZw8/
         Mu6TCfaW+J9eC7+N024rwvwSgECV5zN9OaAa3otly65k1tp8IpQd5lPwF+zQTbdve2DS
         lly5fgd9Oso1zR8f8c6xYbXRQKX6o4lI8abAp1O7SroS0RbG558mfmyUdcNk+cX3VmvQ
         hBB12it8pLoc6Og6zFFmmmOSwhkogRSYQfiw8U7X1jf30SxOQ9hMDgjQvId/EbHm97dV
         AACvzTfo7sQCaf+hLROVJ13BoOj5ZpQWXcaNgQYar3DmBUpfswljb2rlddT1n/e+Yx+b
         uv/Q==
X-Gm-Message-State: AOJu0YyhiAqx94t0lkQvK8B3CG0pvnXUi5mys1dB3P3O0S82izoYMfLj
	piM5YEy0rH7/gyy92huWtqE=
X-Google-Smtp-Source: AGHT+IHEAIhmCRFUOCOZzpSgUheUQ/AOIGSm8yP1AKzyR/8fEl4T7UfNBCAMrwtsI1Cg3QtFnYw8lQ==
X-Received: by 2002:a05:6a00:1390:b0:6cb:8abd:39ae with SMTP id t16-20020a056a00139000b006cb8abd39aemr6843335pfg.30.1700583609894;
        Tue, 21 Nov 2023 08:20:09 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b006c3402c5442sm8087632pfj.84.2023.11.21.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:20:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 21 Nov 2023 06:20:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH-cgroup] workqueue: Move workqueue_set_unbound_cpumask()
 and its helpers inside CONFIG_SYSFS
Message-ID: <ZVzYuHLvWfgIn5qP@slm.duckdns.org>
References: <20231121021840.10937-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121021840.10937-1-longman@redhat.com>

On Mon, Nov 20, 2023 at 09:18:40PM -0500, Waiman Long wrote:
> Commit fe28f631fa94 ("workqueue: Add workqueue_unbound_exclude_cpumask()
> to exclude CPUs from wq_unbound_cpumask") makes
> workqueue_set_unbound_cpumask() static as it is not used elsewhere in
> the kernel. However, this triggers a kernel test robot warning about
> 'workqueue_set_unbound_cpumask' defined but not used when CONFIG_SYS
> isn't defined. It happens that workqueue_set_unbound_cpumask() is only
> called when CONFIG_SYS is defined.
> 
> Move workqueue_set_unbound_cpumask() and its helpers inside the
> CONFIG_SYSFS compilation block to avoid the warning. There is no
> functional change.
> 
> Fixes: fe28f631fa94 ("workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311130831.uh0AoCd1-lkp@intel.com/
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.8.

Thanks.

-- 
tejun

