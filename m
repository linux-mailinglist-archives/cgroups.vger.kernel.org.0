Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3AA200F
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfH2PxJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 11:53:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40044 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfH2PxJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Aug 2019 11:53:09 -0400
Received: by mail-qk1-f196.google.com with SMTP id f10so3375718qkg.7;
        Thu, 29 Aug 2019 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ioZ+JfnsUUD8UiGNxKeFQMLhM3bnVtElsPe+wTUng7A=;
        b=ZGwkXiJHqAtV+JCPJOeiRPEL19aCTJG0iUo1GcyA13cQXILHAX71nOjecvBWnxh33S
         /I76lZ80uyyYxLB+BwAFHTIEgiWBKPQ4tbZ1PC6Q9VVA6sSFcrat7NmGapzjPQ0I3Bqt
         5rqWkN+uqw49TlREjShKZxY+d0FbxhvZciKk2kOh7bscxdTNuy00hZwY58BSUsnrcXE3
         +f9DP7dTz6EwsOJKQ6Q6uox/0PPe8w7wUbOkI8jky8+W8uXrkEhGHt7u//bpCR21cUxQ
         XvaShzQ4s4IWaclSTZ1kxjbU9BcEpx/jsKlyWeQ69iG44mLZJF0eEexc0vQy/GXrorhQ
         62Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ioZ+JfnsUUD8UiGNxKeFQMLhM3bnVtElsPe+wTUng7A=;
        b=Bnm96XRnP6eFIjtTGrBW+f1vNyqo3B2px5GVL92hqbE2DGfylRDPw5sdKwPB8P6O/M
         q8n3xuRGW/nj0v4zWLum36QQ5PhnOfQ2bNAxBTqmU+ecnJIOYIL92E7+X3Zg35hyoyOJ
         YXvRcZ2h4mQoGvSujBxxwEInk7NBOrbiYwPHLwamvpWVvI5gj0yQQFU/SBB8LVpycBv+
         0EIO4DmeGWGUX5js7gKVh1mt2wXp5cnVBKZEGU0rd9Y95xZqij/5r8eNKnrbCdVuVoBJ
         TcnFye3dpXB7TM33D56CS+rGUmhZUNHFp8labCUOvJRB1V8VDeTAwtczYQXYLweZ5O6J
         RwCA==
X-Gm-Message-State: APjAAAWMA3YEtvgyunnXDxf7jMrtNIs6rHbAVQt+QydHiU4i3BLLyxLg
        e2q248zI3E4ScCe1hWQPczY=
X-Google-Smtp-Source: APXvYqwy8ArwZBXuNODCrm1hx/Tim+bxxFK/HmQoDiBz/izywvIWX17O1I6StSKaHH6tIga65OLJKw==
X-Received: by 2002:a37:8e06:: with SMTP id q6mr9566213qkd.89.1567093988083;
        Thu, 29 Aug 2019 08:53:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:7e32])
        by smtp.gmail.com with ESMTPSA id h13sm1359655qkk.12.2019.08.29.08.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:53:07 -0700 (PDT)
Date:   Thu, 29 Aug 2019 08:53:06 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>, Rik van Riel <riel@surriel.com>
Subject: [PATCH] blkcg: fix missing free on error path of blk_iocost_init()
Message-ID: <20190829155306.GV2263813@devbig004.ftw2.facebook.com>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828220600.2527417-9-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

blk_iocost_init() forgot to free its percpu stat on the error path.
Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Hillf Danton <hdanton@sina.com>
---
 block/blk-iocost.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index f04a4ed1cb45..9c8046ac5925 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1876,6 +1876,7 @@ static int blk_iocost_init(struct request_queue *q)
 	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
 	if (ret) {
 		rq_qos_del(q, rqos);
+		free_percpu(ioc->pcpu_stat);
 		kfree(ioc);
 		return ret;
 	}
