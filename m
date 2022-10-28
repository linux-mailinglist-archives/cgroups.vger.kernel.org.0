Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF9611597
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJ1PL6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 11:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiJ1PLz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 11:11:55 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13920B12C;
        Fri, 28 Oct 2022 08:11:54 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t10so6441468oib.5;
        Fri, 28 Oct 2022 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cu5lq0+6QCF+BQfiaiaRxPUIRB+CVrNKwv+C5DY2DeE=;
        b=jrBrEVx/TWlLwC/EybmMjgT1gIVbiJljUHbETA5hqF92YxNbERFPM8SLV8vK+xyqHj
         9jS6lbrYopAtUqlTWoxmEhrkvVuOVnKHs18xrfkN3sQdJWGdEM8ayfOV6/rcHN9MyDGS
         idiwJN9NfCM2e8NN2NyJ75qSfH6Jw5L/noLRcBMacXiiXUYWcEoONMWesL4OC1T+SBSX
         zRJEmoAlv5F1PTO0uNPS0M5lwoafv7bkttb/uiMKOTZ5pxkfWBm0uH+r/cEtQLtmdLZy
         0aGvxyZT6rXQbiuz2oOdZEl+0+YjZU9rPHTO3PCCSEnn0aiYzAOnagzZG5lkxCKy6xOI
         2NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cu5lq0+6QCF+BQfiaiaRxPUIRB+CVrNKwv+C5DY2DeE=;
        b=Dd2rETFce9mElrsOojZlwlfYpjlZlU0DXgL0lvymg30LR0XsRvxBSi+ghxoehZDzGr
         4hdEXF1rO+ukWz3oe39hDvH1rcXhmpC9Uz33HyrZ8sME1RDVqGZHdD8ssBUKNvY7vkSe
         lDtX8PAlI7sOGFQQNIYtqhU2JSUbv4yKl/VJMpVyLoqRugNIltZWO0HSk7PGwH7S27ec
         iUMcGJI013PFv7P1USZn/WYcSh8ejVwSnB/5sDkuBuvCCFhYQABYOf6UqusUpk7XJDCQ
         KJ7ucN3DtMbxv3bi/0wenY1i/r6djX/rTZXjG3yBCANo9k+seAxUuEK2XnXL/AnasPLr
         9pxw==
X-Gm-Message-State: ACrzQf3j1jmQeafjuUIFZJ3NQsQXj5fqdPOLw7NVfgTAiocvw7Y7cQ1h
        Kv43eBPtwkyPac8GA4nbKGlY1+YK2yg=
X-Google-Smtp-Source: AMsMyM5ueVBq7cyjALr6qHrZIqC5QSucVyONEpEUiPzqEpDhX0YcC10pHst5clJUzxGlqh+WW2rQcw==
X-Received: by 2002:aca:b443:0:b0:359:a4dd:c0 with SMTP id d64-20020acab443000000b00359a4dd00c0mr8575830oif.234.1666969914064;
        Fri, 28 Oct 2022 08:11:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z21-20020a9d62d5000000b00666fdab9da7sm1739449otk.78.2022.10.28.08.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 08:11:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6f04aec5-bbff-6154-a0b1-8ad0aec97ec5@roeck-us.net>
Date:   Fri, 28 Oct 2022 08:11:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC][PATCH v2 04/31] timers: block: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20221027150525.753064657@goodmis.org>
 <20221027150925.819019339@goodmis.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221027150925.819019339@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/27/22 08:05, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, del_timer_shutdown() must be called.
> 

I also had to add the following, as you had already suggested.

Just changing blk_sync_queue() was insufficient; I had to add the call from
blk_release_queue() because otherwise blk_sync_queue() was not always called.

Thanks,
Guenter

---
diff --git a/block/blk-core.c b/block/blk-core.c
index 17667159482e..69b1daa2e91a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -227,7 +227,7 @@ const char *blk_status_to_str(blk_status_t status)
   */
  void blk_sync_queue(struct request_queue *q)
  {
-       del_timer_sync(&q->timeout);
+       del_timer_shutdown(&q->timeout);
         cancel_work_sync(&q->timeout_work);
  }
  EXPORT_SYMBOL(blk_sync_queue);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e71b3b43927c..12a1e46536ed 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -769,6 +769,8 @@ static void blk_release_queue(struct kobject *kobj)

         percpu_ref_exit(&q->q_usage_counter);

+       blk_sync_queue(q);
+
         if (q->poll_stat)
                 blk_stat_remove_callback(q, q->poll_cb);
         blk_stat_free_callback(q->poll_cb);

