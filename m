Return-Path: <cgroups+bounces-329-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9354B7E854D
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 23:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B799F1C2097B
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 22:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F63C6A7;
	Fri, 10 Nov 2023 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7InLcbm"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013113C694;
	Fri, 10 Nov 2023 22:06:02 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822F24229;
	Fri, 10 Nov 2023 14:06:01 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso2330781b3a.3;
        Fri, 10 Nov 2023 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699653961; x=1700258761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQsMe074MamB2yzTQo6W7krdrCcJW4RDQzQCxoPsHD4=;
        b=g7InLcbmdDLab1Lx4iUOYFwcWf5rys/9CPVZDHc+MVA9HxZd+N/QeHGCszQqNX52vA
         AyUqHKWVqR4nTQGD9/jAeiiB9AmQ8ofIfxhCwFDBAdpDKMmXuDOHkicAMsX1B11aRz44
         6/SDdn5J/WG4Ur7hXNtGN4ZUzS/vxFq+JEbomXPpr1fDq9wqk2eYqQbLBXJl6q6mI6SR
         TCfykjAvK6dKJcBtJW5xxwNQiV9yzzKMAq0QNUA3P5RSntzPPO/FajSn5YW06S6KU0gM
         l1Ky6N2wO5MThQe9e1c4BPdlAR7N+GyLXAn0odULZzvNKIxa6bRzkE9/+VP8A8dqWBa7
         L4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699653961; x=1700258761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQsMe074MamB2yzTQo6W7krdrCcJW4RDQzQCxoPsHD4=;
        b=LuzAin1TvQG6FWeWVp3t1bTGWPnO4iL4cPooR1pQKpwBffv+vlbX06L0sYraMOosy+
         aalQXCubrXtkNYGtJVsIqjEy74J04Csl8CgS+C2E/HaMta2WcX3Fkqem2ADTnSi8d4DG
         cskTMDS3RPTL8jIPjG9AHZNJPDvWKq3kA9lL03dFxRw8VCRfJrJ4w6gFQCwiJ1zg+usX
         voAmsvEAiN8wRSuf6Ir80jotFVObqepAXspPG2wc1H4zSaJg0gZZq+q5iKRe4P05kDPa
         kEvEmjV81xRJ6543g2Kze7gITU8JYAm+hR1PrvhM3nuOSnyno3N6oq2JBmlGK7LwJBfV
         MO2A==
X-Gm-Message-State: AOJu0YwkuFq56nYqakA1iMFtVnF3ycVSh76G9776XySEBWUcWcnZ6li4
	vCAXnYOVKUGhQXPjFnYP+6M5YaedZlM=
X-Google-Smtp-Source: AGHT+IGmYD+iLSGJMZ1bWcW3JwFA+GQuAkLKnNRr9ZRnrpf2Iuo4IbP+yoj9cl8CDjWN8FMq3eC3SA==
X-Received: by 2002:a05:6a21:7746:b0:181:a3ae:115b with SMTP id bc6-20020a056a21774600b00181a3ae115bmr438823pzc.61.1699653960858;
        Fri, 10 Nov 2023 14:06:00 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id fm26-20020a056a002f9a00b0068620bee456sm180253pfb.209.2023.11.10.14.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 14:06:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 10 Nov 2023 12:05:59 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: John Groves <john@jagalactic.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"ying.huang@intel.com" <ying.huang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mhocko@kernel.org" <mhocko@kernel.org>,
	"lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
	"shakeelb@google.com" <shakeelb@google.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	Gregory Price <gregory.price@memverge.com>,
	"jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZU6pR46kiuzPricM@slm.duckdns.org>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>

Hello,

On Thu, Nov 09, 2023 at 10:48:56PM +0000, John Groves wrote:
> This approach checks all the important boxes: it only applies to apps where
> it's enabled, the weighting can vary from one app to another, the
> kernel is not affected, and the numa topology is not buried.

Can't it be a mempol property which is inherited by child processes? Then
all you'll need is e.g. adding systemd support to configure this at service
unit level. I'm having a bit of hard time seeing why this needs to be a
cgroup feature when it doesn't involve dynamic resource accounting /
enforcement at all.

Thanks.

-- 
tejun

