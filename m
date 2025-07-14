Return-Path: <cgroups+bounces-8731-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF5B04C95
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 01:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804D71AA13FD
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636D277CBD;
	Mon, 14 Jul 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVL4FKo3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D5248869;
	Mon, 14 Jul 2025 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537514; cv=none; b=Goi5jBFZ7b4fFiY3f5VVhS5CiVSuAHk5TT2oFo9pZg0++AOF+aWyijHj+gDLRTSNDgsi8FkFc76evpCX5mzIpsrhxrazCsr3nrf1PgSkNzIgTMsa8QX4c68A09bB6OS+sLqDCJLKpDlzZypN0AV+yz6BkwavWysfBSMANZncMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537514; c=relaxed/simple;
	bh=5q5nESWdsqhiVufoOV0EPOiccfQFccbVLeQwgs4kfYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OLhAtNPld87tLY2lS9HiI+ADlUCuQ4j2kdQTij8eZYZTyIad5bSiVd1wi3ITVTsmKTF+b1jf8FRQzwmMlXnXNKFWEi5haQcgGXovpmW4XCRdVHI0OIVr75d8KMvqPqo1jIiwVYantjgrY8FGc34eSH0x00x+PIcbcSHiX/ypc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVL4FKo3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2350b1b9129so33701965ad.0;
        Mon, 14 Jul 2025 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752537511; x=1753142311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCrqEm/DxFBD1hPDI0NYCjLYHyzFrXQGNfTsWUPxUFM=;
        b=RVL4FKo3p/ZqjWmDfivhXB45KxpO2lJIzXpLfThkBG6IzL3jsU/qEZq3YBBwoVS781
         wVl6K1eCUmeyrHtkiq4/UQSJPnVHR0ODeXRhAoCCJjbHLDmb4v4UvKdD2/3dIPPXLSNc
         iaO8lWUhBoOHuprJmAdPdoKOeiW6pfTNLkut9/gW+yq/4a/BrntM+T02MimnJDWLFw8k
         NDyUL8uXZoG3TIZEddI0c5y5vEo/mDdoXsmXOGiiYFr53gG06LCp1DZjzNQ5usEFWDf5
         LZ5Do2VkOuxdmD+F0KobQZ8UTBSd+Auag2D/wHsJz6vxMmw68cg3398Ja8EmZkn3m588
         w3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752537511; x=1753142311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCrqEm/DxFBD1hPDI0NYCjLYHyzFrXQGNfTsWUPxUFM=;
        b=bKewg6NVT94b3j2ugWFtskfhzJyiWnc7bIImt/e0uwjjwRDl58Cj1ryIpuwT5K9zw3
         cW+g6fnpn6lPXD1jpJTJr7HaaV1csOZt+/C9DqubQBv9N31VxcHk4Q0bf7dOHnNVSdQq
         2t5JNz0msGUEV6tjWpuAUvfWI0s6DUftWmy4+0nSo61UZzbNhJlyiFqHRroVsY6+hzOb
         okdEEIioCtV9ChIJy8CoqnxlhJLA5XcwqQIVrjlQbtq9dRdMp07midbD0edowahNUS2i
         ukTCaIDDXhpk0PHCgfCpR3O7p3fi2friQ063MSf4yuDQ6L8XYSqDR6n33RgMl4UEJnO4
         I+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUK4Xu79oqMHcMpJNylVX7w3Q8z/WbdVOOqK4W9WDRMktp2lwGux5BsBT+TynowjViOYRl5zN/w@vger.kernel.org, AJvYcCXQukh/RPxUjW84myi28SKIBWmddnbZXIsvV/WBcGLVdpO7urGCVbuyfSP95DA3qPadaHdACCOPeno7T20O@vger.kernel.org
X-Gm-Message-State: AOJu0YzBeYc1goqnZl5kh/Pg7zDbKRNzoJUA5JoaiLBvDC1zwaISqjMQ
	IaRbMpn/Ay0mmLndrXqv7Bp3a0DNdbG4SaFv7jSKxIVhte30JyHGhSQ+
X-Gm-Gg: ASbGncv2FJLs5A+wtC0Z3QbW0PJkHBPO0aCOqvRZOMfxGh3dyDPWGSOls8Sfkr+BWPE
	KpbEM+1BiwaBCHPSwv/5gDgdCrqWNKB3tHVG4rYhlXXyyvC+jvIAElQiz4UPxTFv9kLPN/NaTwH
	rCiTJAxPf8hJO6Xjp1R22c4tJjcw7iBwnsFkL9SuPVmTJPyDmqnlznxPrxDTH15lkqJpxFdHeo3
	VWWKfQnwvESiblk7cY9iu4fFHIxoBnk21aovAk2TG5tpktIbnjAd8LrpBNbsuZH9pj31PRcC5uZ
	slNYgK1OGX15kmQC7Qfy3olqSZDC+GJOqQ+ykKzt4gFFyv2y+AW3dH7HbYoZn93UwfSEdecsvw3
	gZ+OME7CDLry0xoQHTmA9dClojKJkQZVl6Qbh5OPxNzDRsw7fKI+3vQv6DPRN25edLNUg
X-Google-Smtp-Source: AGHT+IEaT5+ArvhktWHGmPNWYoMjwY3m/hW32IQPZWD6WPfa27Btx30+hgzX8aJJYN/bQGg4Qfh6jA==
X-Received: by 2002:a17:903:17ce:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23dede468b9mr266829875ad.16.1752537511461;
        Mon, 14 Jul 2025 16:58:31 -0700 (PDT)
Received: from [192.168.1.117] (c-67-180-10-175.hsd1.ca.comcast.net. [67.180.10.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323e2asm97829105ad.110.2025.07.14.16.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 16:58:30 -0700 (PDT)
Message-ID: <65df1f7e-9512-4527-bbe4-0cf10877f4ba@gmail.com>
Date: Mon, 14 Jul 2025 16:58:29 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
To: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 12:29 AM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    5d5d62298b8b Merge tag 'x86_urgent_for_v6.16_rc6' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11dabd82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
> dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162c47d4580000

#syz test

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a723b7dc6e4e..e6c5c998ead6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5669,6 +5669,12 @@ static struct cgroup_subsys_state 
*css_create(struct cgroup *cgrp,

  	init_and_link_css(css, ss, cgrp);

+	err = css_rstat_init(css);
+	if (err) {
+		ss->css_free(css);
+		goto err_out;
+	}
+
  	err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
  	if (err)
  		goto err_free_css;
@@ -5678,10 +5684,6 @@ static struct cgroup_subsys_state 
*css_create(struct cgroup *cgrp,
  		goto err_free_css;
  	css->id = err;

-	err = css_rstat_init(css);
-	if (err)
-		goto err_free_css;
-
  	/* @css is ready to be brought online now, make it visible */
  	list_add_tail_rcu(&css->sibling, &parent_css->children);
  	cgroup_idr_replace(&ss->css_idr, css, css->id);
@@ -5697,6 +5699,7 @@ static struct cgroup_subsys_state 
*css_create(struct cgroup *cgrp,
  err_free_css:
  	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
  	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
+err_out:
  	return ERR_PTR(err);
  }

--

