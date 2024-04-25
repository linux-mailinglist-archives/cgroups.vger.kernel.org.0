Return-Path: <cgroups+bounces-2706-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031FF8B2779
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 19:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43F2282CD7
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C9214E2CD;
	Thu, 25 Apr 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOQHSu3E"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E841E864;
	Thu, 25 Apr 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065476; cv=none; b=PoITy2LeTxkkzgNsLE0k0qpHAjJGGMjHSG79IWgwBMNl3sVogEcMe7rKZ636fc0BTHU9Dqeydpas1J/Omv96tnOMtk7UKY40Oo6pd5b/puC0Hxl0pf6VgzF3/o2qNbqqW0GU5IdbMdp/TU1vFtGcF12eJ8UKoE6o8IsVzFtLRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065476; c=relaxed/simple;
	bh=5snC8iqMbQWNRgYRrgyDI6dkWLiaUWRHNAhR4zzs6AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOdrWz8bQ9wtIJQ1QL3i2fxjVbidSUBmTItMXTu2Dao8R6cEGjpVa3yGKldTA0qbbkGxCKUMqsmBh/1QqW6PGvT6YEAktncaunP3+fbdWCz5xTk61U2YtKbxKY5Irc5KnP7ba0drz0jDkHNdCgF9KPAR3gQ/aWak1WlekvFP37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOQHSu3E; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e9451d8b71so11070265ad.0;
        Thu, 25 Apr 2024 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714065474; x=1714670274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UL5saDl1/HYC9QxiX3OYDnCtXKbXFzyViYUmGWcWo3w=;
        b=UOQHSu3EGyfmU2GcqbJjrq7wz0/iJVuzQ1axE2axe7cpbbk8LHz7jaJDSD+GAePWFx
         r6e4UTMIF1mC3OwGT5TsXrIypRMAV41CHFAQTJvKT2Xs7u5wlQ5NnHcrOcB6ku10VnSd
         Yp0ueq1lf3W/aPseCVn0Q0m9SkKTTmU73FSRcMApxxU5PQ78AKONAW4XBHQDOHUbYA34
         RnIMPo3a8K7zMRtGZelXsal09hg0mKsbr3z0T2IzjlM4CJX7l8InKUd/wG7xTrPLmT7/
         b5o4KfUzRwfafG1MhZLFAkTGb275C7bRmZ42rYK9qOgGkLcw6FhE63NGl64IKYqNdLo2
         3ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065474; x=1714670274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UL5saDl1/HYC9QxiX3OYDnCtXKbXFzyViYUmGWcWo3w=;
        b=Dr8iRHRSkaCMjPUsaqA44mHHg3tiZY++Vhd/jAGUGbcygu7HtxUkfc5qIpQk29viU4
         nLj+lCcfF4BwvwdwxVj/rnE4HMXIH1rMFskuCIIk+w2ejCyJJCqPGgmC6G/S4B7BzR8U
         27gFJCu0b3xqjrcvvZI9R1lnETtpFuzoUsHzzuk3uiatDhdMSnHpCguyB0atIlXSv2Sy
         WfMANoHqsEoYmWDsHaxv65ZR0OVS/Kdp/lv0D0VSv7rKT2BEiN5AqfhlbNc5z7toGg4L
         YHUXEjrLpfSjUwAIPYJCy7Rw7la3q+fZ1OG+h7xTeXBlIP+aQEgoZxualwfDDJ9GMY0X
         p4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHoYidjomeaYNGEn4t1GIhR3yg1jlr7eiWx7ff/J7RnG9WODuQLuh4xQr3/WAJrddMdM+T6yQ4WjvUGZbmHW7yRu4Qo6fVObP6cBo+0veW82qTAZB21DtwcA9L9bplz7kNS4+qlQ==
X-Gm-Message-State: AOJu0YxEf/9QLHW4rh6aHrlqRkBBUSe1U4/OjmJyCysTOo8Rry6zY6So
	c0vB4bo1qu7m31RxAYQVH/llemfh7iZRu3LoK5MaEWls3Zdq4A1L
X-Google-Smtp-Source: AGHT+IHqo9Qxba+7U0d5wxma8FuytFh+BWKBGanl+d15UZ4FatVV71SiA8rtledZVrDTc4EZ35NiJg==
X-Received: by 2002:a17:903:1c2:b0:1e0:ca47:4d96 with SMTP id e2-20020a17090301c200b001e0ca474d96mr184034plh.3.1714065474383;
        Thu, 25 Apr 2024 10:17:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4652])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b001e83a718d87sm14042745plq.19.2024.04.25.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:17:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 25 Apr 2024 07:17:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: Remove outdated comment in
 sched_partition_write()
Message-ID: <ZiqQQJG2I5WsGKt4@slm.duckdns.org>
References: <20240425093016.1068567-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425093016.1068567-1-xiujianfeng@huawei.com>

On Thu, Apr 25, 2024 at 09:30:16AM +0000, Xiu Jianfeng wrote:
> The comment here is outdated and can cause confusion, from the code
> perspective, there’s also no need for new comment, so just remove it.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

