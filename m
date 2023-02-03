Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DFE68A334
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 20:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjBCTpi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 14:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjBCTph (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 14:45:37 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C5C9DCB3;
        Fri,  3 Feb 2023 11:45:36 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so5302550pjp.0;
        Fri, 03 Feb 2023 11:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj5Tu5E7CoXMz7arwXQAyRVyy8gsxIDydTYsQXxz6MI=;
        b=eRHLknci8CkKlOiAS1V3rJd+h+Gz+LMf9htRD2ZP0/ZqKxX66hOUxl1nUHFDa48K5D
         OdmegWpOsMDi6mdUh+HBIo0IDSVre4xyZ8Z1nNtmzxq9WUhXxh6pumRaeF60QEt03vCU
         Iu7moFogf2F3oBfL7R4mFljX/L+nMUf6ggsiUAW69FANv4M/xBjFGJc+pYNUjDb7TRi1
         qDgokkLDS4/fi4LBu61bndIHSJkaa6OlVOc0irOz5QfLsDb9MEuUHVfVI8q80MTsSxTb
         yLEIbfHV2nhqisrCjz38tZIYxn2kE7ZyHpWpMBJwBHohDu7HMLKZPyPi7gZCSIermwuF
         tTYw==
X-Gm-Message-State: AO0yUKXVZShTuZhvh1pa0l8YvNpUeJMlCERhWyO8oRBBpgMfsVgoaRQI
        NN62Ga7yZbdMa5ZXYUZZVeen+ZwSLIY=
X-Google-Smtp-Source: AK7set8nM63+1pdXNGI6Lh0b+Jhps5kT2dzVbEI+pm1NCG1DTXT02+dcEWAhm+o+/xxoiYvyp3PF6A==
X-Received: by 2002:a05:6a20:d906:b0:bc:e64b:e79b with SMTP id jd6-20020a056a20d90600b000bce64be79bmr7074418pzb.1.1675453535679;
        Fri, 03 Feb 2023 11:45:35 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:b752:5d03:ec5e:7be5? ([2620:15c:211:201:b752:5d03:ec5e:7be5])
        by smtp.gmail.com with ESMTPSA id g20-20020aa796b4000000b0058bb0fb6295sm2219377pfk.26.2023.02.03.11.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 11:45:34 -0800 (PST)
Message-ID: <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
Date:   Fri, 3 Feb 2023 11:45:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, linux-block@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
 <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
 <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
 <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/2/23 17:48, Hou Tao wrote:
> I don't get it on how to remove IOPRIO_POL_PROMOTION when calculating the final
> ioprio for bio. IOPRIO_POL_PROMOTION is not used for IOPRIO_CLASS values but
> used to determinate on how to calculate the final ioprio for bio: choosing the
> maximum or minimum between blkcg ioprio and original bio bi_ioprio.

Do the block layer code changes shown below implement the functionality that you
need?

Thanks,

Bart.



diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8bb6b8eba4ce..4a56da95168e 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -27,6 +27,8 @@
   * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
   *		IOPRIO_CLASS_BE.
   * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
+ * @POLICY_PROMOTE_TO_RT: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_BE into
+ * 		IOPRIO_CLASS_RT.
   *
   * See also <linux/ioprio.h>.
   */
@@ -35,6 +37,7 @@ enum prio_policy {
  	POLICY_NONE_TO_RT	= 1,
  	POLICY_RESTRICT_TO_BE	= 2,
  	POLICY_ALL_TO_IDLE	= 3,
+	POLICY_PROMOTE_TO_RT,
  };

  static const char *policy_name[] = {
@@ -42,6 +45,7 @@ static const char *policy_name[] = {
  	[POLICY_NONE_TO_RT]	= "none-to-rt",
  	[POLICY_RESTRICT_TO_BE]	= "restrict-to-be",
  	[POLICY_ALL_TO_IDLE]	= "idle",
+	[POLICY_PROMOTE_TO_RT]	= "promote-to-rt",
  };

  static struct blkcg_policy ioprio_policy;
@@ -189,17 +193,23 @@ void blkcg_set_ioprio(struct bio *bio)
  	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
  		return;

-	/*
-	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
-	 * correspond to a lower priority. Hence, the max_t() below selects
-	 * the lower priority of bi_ioprio and the cgroup I/O priority class.
-	 * If the bio I/O priority equals IOPRIO_CLASS_NONE, the cgroup I/O
-	 * priority is assigned to the bio.
-	 */
-	prio = max_t(u16, bio->bi_ioprio,
-			IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
-	if (prio > bio->bi_ioprio)
-		bio->bi_ioprio = prio;
+	if (blkcg->prio_policy == PROMOTE_TO_RT) {
+		if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) != IOPRIO_CLASS_RT)
+			bio->bi_ioprio = IOPRIO_CLASS_RT;
+	} else {
+		/*
+		 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
+		 * correspond to a lower priority. Hence, the max_t() below
+		 * selects the lower priority of bi_ioprio and the cgroup I/O
+		 * priority class.  If the bio I/O priority equals
+		 * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the
+		 * bio.
+		 */
+		prio = max_t(u16, bio->bi_ioprio,
+			     IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
+		if (prio > bio->bi_ioprio)
+			bio->bi_ioprio = prio;
+	}
  }

  void blk_ioprio_exit(struct gendisk *disk)

