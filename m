Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645D5790C6E
	for <lists+cgroups@lfdr.de>; Sun,  3 Sep 2023 16:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbjICO2O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Sep 2023 10:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbjICO2O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Sep 2023 10:28:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E2B97;
        Sun,  3 Sep 2023 07:28:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c3b9f8333so340632b3a.1;
        Sun, 03 Sep 2023 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693751291; x=1694356091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjy5F3GLFbzbY5Veg10sJXncHFcZhNqzR3hA1fgbxTA=;
        b=cdFTQqqsDTeRINqpsMTKC2OPmXg59qKykpNyvZwX4LhU46NrFvBlbPJQo11Cgfh4TR
         XD1jUwLVvPWd9rMvKvaLPYAfxdPD9Diea3P9MZTl72+Ma5ODcubogdVO7OBzZkp2rG2H
         Z7BS0be/KQ5Z79XfKnyJ9BcpJlUvIkkOVryMqCln1/bNbDD/UKbw/Eq/d/zNefmmDjvZ
         ZP5LjUU2vM7eVeOsvJNgTsodKZc7toTwdiyl6RdyOkPYCIF7Ld3zRY+4UQCPXlXKsYsM
         OzPc2zI9Wbw7uxK4dOjo7wHyQsQhN8mqnY9geYjSZxwU3iKNGE0L1VespYXF03zpR901
         15cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693751291; x=1694356091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjy5F3GLFbzbY5Veg10sJXncHFcZhNqzR3hA1fgbxTA=;
        b=eviPEKgTOwwplNfYg1H5BJwx4cd/egou0DaXThjHVSWJ+O8zYf98ZC6XxUQSRtvgpj
         ew4m1bFkogZ2B84q4KckhC0iucpc4UAVOjxQJ18Cqh49K5j4hHagCQDN0jTXnukXiKKe
         MXg0ZhJ2PDqtJqNY9amQOXfCkOS/hCxzTAtSqb72AfYtt7vAhNongWCqUrg/i8N4p4cZ
         yYu2kW8IsTW2e1r7QeO/1bteAZ6vZRrrOe4vcK2L8orfk6mFrWfshp0eHENvPzUBOz/4
         CJRoWm9qJqJ1iJxuVlglhMwNT0EfHjdZQjl9KhXcCw/2Zn9X28dFXB9YEIQk1HlrNziw
         wpig==
X-Gm-Message-State: AOJu0YxgxUl3wt8RLBGCn8PI8BBuTfaxh0pnUAgz8z58FAj15IUppF+D
        qHzTUGs9eOgRASB59zFmylk=
X-Google-Smtp-Source: AGHT+IFh5BUV/PWiZfvyHOKjMcTIEJkoFfn1UHQWnmSqJ4mqCxqezQnl+prtpsTeZNSVYsCu9DQbvg==
X-Received: by 2002:a05:6a00:328b:b0:68a:2c6e:c2cc with SMTP id ck11-20020a056a00328b00b0068a2c6ec2ccmr9771054pfb.0.1693751290755;
        Sun, 03 Sep 2023 07:28:10 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:185:5400:4ff:fe8f:9150])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78117000000b0065a1b05193asm5809977pfi.185.2023.09.03.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 07:28:10 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/5] bpf: Enable cgroup_array map on cgroup1
Date:   Sun,  3 Sep 2023 14:27:57 +0000
Message-Id: <20230903142800.3870-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230903142800.3870-1-laoar.shao@gmail.com>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The cgroup_array map currently has support exclusively for cgroup2, owing
to the fact that cgroup_get_from_fd() is only valid for cgroup2 file
descriptors. However, an alternative approach is available where we can use
cgroup_v1v2_get_from_fd() for both cgroup1 and cgroup2 file descriptors.

The corresponding cgroup pointer extracted from the cgroup file descriptor
will be utilized by functions like bpf_current_task_under_cgroup() or
bpf_skb_under_cgroup() to determine whether a task or socket buffer (skb)
is associated with a specific cgroup. In a previous commit, we successfully
enabled bpf_current_task_under_cgroup(), ensuring the safety of storing a
cgroup1 pointer within the cgroup_array map.

Regarding bpf_skb_under_cgroup(), it is currently restricted to cgroup2
functionality only. Nevertheless, it remains safe to verify a cgroup1
pointer within this context as well, with the understanding that it will
return a "false" result in such cases.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/arraymap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89..30ea57c 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1291,7 +1291,7 @@ static void *cgroup_fd_array_get_ptr(struct bpf_map *map,
 				     struct file *map_file /* not used */,
 				     int fd)
 {
-	return cgroup_get_from_fd(fd);
+	return cgroup_v1v2_get_from_fd(fd);
 }
 
 static void cgroup_fd_array_put_ptr(void *ptr)
-- 
1.8.3.1

