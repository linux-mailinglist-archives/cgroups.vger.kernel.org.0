Return-Path: <cgroups+bounces-178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89867E191F
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 04:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F93A2812AE
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 03:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736F1391;
	Mon,  6 Nov 2023 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THagRRDv"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481DEB8;
	Mon,  6 Nov 2023 03:18:11 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A863FB;
	Sun,  5 Nov 2023 19:18:10 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-577fff1cae6so2928476a12.1;
        Sun, 05 Nov 2023 19:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699240690; x=1699845490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rrlgew2gk8PDDg6nKa3/Skvn3+IsqivqOV1shk2EdlI=;
        b=THagRRDv6vaEOzVrdd7OMGg35B2V1AFrIVBkBMSfVX5ZV3fT4jMNWRQMi2WH0yD2lT
         Q3CqDPOXDOwnh2saqzfGcaj/alDYnmc11hFn8pRtgUe5F1d7Fvr7nOuw2radQrPIqJkY
         37quSOkvBKa99e+i3zlLUYsrHYlIXQ6VUCfDKndycJO8S8Wz2+6VtExxUG8kQf3o7VHn
         mTXki+yNHsdhoA5iX5z6ZyCd1KwRz1rFvTIyciT5Wadr2Jzm06NvRYVdoWr5bkZltv/+
         2ZR4FLPpAKjw/AnHAgjC2jPs+mQbrxDvh/CGvOb2dfzc3vaXrrFE7ZVBJW/dKSywrKZY
         TD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699240690; x=1699845490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rrlgew2gk8PDDg6nKa3/Skvn3+IsqivqOV1shk2EdlI=;
        b=sFJpPAd2VND2TP7doh+t+q5fNh3Vkf/wQ5lYMT6fKPvnVUQRpw0doAFKQgOSEc2+6P
         jq18xGnGSzpBukej/lxw+0W8OXHmrnXC90pNhGSW51/1Iv/NFnLESYyHxLQbXuE7txcy
         FGCHP8TLKQeRqdYHnBODg+QOeVW2ni81MfXPQqSkwvBcdKSpYL9KGNyyjVbK115MxKiy
         11B5sleYFroxQAR5A08iWVW4sNIvCAEdw2E1TejKZcWi8JfkiMJAHWmA6/S0vT4HiL/k
         6FJRbHL9GGrNub1fIH4N4bbvEzPxGsjnfo2WdXd+LIOUL6d142pQ31/uwvH06D+xW9Ns
         3mpw==
X-Gm-Message-State: AOJu0YwIIwLhoM0ACbz+yvPWcV/7xVw+RjUOqDU/9hGvTpjBQSck9e+4
	IdSioQsK2O5Mq1qfm9WNk+uxqul5F5pSpsPBmyc=
X-Google-Smtp-Source: AGHT+IE05Xu249woaU1bL4qVqak8SD6uvJifofA4I503pNRx8WM4s8Wg4W12izbH6kRNArk83b4WLQ==
X-Received: by 2002:a05:6a20:6a20:b0:17a:eff5:fbbe with SMTP id p32-20020a056a206a2000b0017aeff5fbbemr12943122pzk.8.1699240689600;
        Sun, 05 Nov 2023 19:18:09 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:4238:5400:4ff:fea3:2cd4])
        by smtp.gmail.com with ESMTPSA id ei4-20020a056a0080c400b006c31b4d5e57sm4625624pfb.184.2023.11.05.19.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 19:18:09 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: lkp@intel.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	daniel@iogearbox.net,
	hannes@cmpxchg.org,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	laoar.shao@gmail.com,
	lizefan.x@bytedance.com,
	longman@redhat.com,
	martin.lau@linux.dev,
	mkoutny@suse.com,
	oe-kbuild-all@lists.linux.dev,
	oliver.sang@intel.com,
	sdf@google.com,
	sinquersw@gmail.com,
	song@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	yosryahmed@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH v2 bpf-next] compiler-gcc: Suppress -Wmissing-prototypes warning for all supported GCC
Date: Mon,  6 Nov 2023 03:18:02 +0000
Message-Id: <20231106031802.4188-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <202311031651.A7crZEur-lkp@intel.com>
References: <202311031651.A7crZEur-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel supports a minimum GCC version of 5.1.0 for building. However,
the "__diag_ignore_all" directive only suppresses the
"-Wmissing-prototypes" warning for GCC versions >= 8.0.0. As a result, when
building the kernel with older GCC versions, warnings may be triggered. The
example below illustrates the warnings reported by the kernel test robot
using GCC 7.5.0:

  compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
  All warnings (new ones prefixed by >>):

   kernel/bpf/helpers.c:1893:19: warning: no previous prototype for 'bpf_obj_new_impl' [-Wmissing-prototypes]
    __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
                      ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1907:19: warning: no previous prototype for 'bpf_percpu_obj_new_impl' [-Wmissing-prototypes]
    __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
   [...]

To address this, we should also suppress the "-Wmissing-prototypes" warning
for older GCC versions. "#pragma GCC diagnostic push" is supported as
of GCC 4.6, and both "-Wmissing-prototypes" and "-Wmissing-declarations"
are supported for all the GCC versions that we currently support.
Therefore, it is reasonable to suppress these warnings for all supported
GCC versions.

With this adjustment, it's important to note that after implementing
"__diag_ignore_all", it will effectively suppress warnings for all the
supported GCC versions.

In the future, if you wish to suppress warnings that are only supported on
higher GCC versions, it is advisable to explicitly use "__diag_ignore" to
specify the GCC version you are targeting.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311031651.A7crZEur-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compiler-gcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7af9e34..80918bd 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -138,7 +138,7 @@
 #endif
 
 #define __diag_ignore_all(option, comment) \
-	__diag_GCC(8, ignore, option)
+	__diag(__diag_GCC_ignore option)
 
 /*
  * Prior to 9.1, -Wno-alloc-size-larger-than (and therefore the "alloc_size"
-- 
1.8.3.1


