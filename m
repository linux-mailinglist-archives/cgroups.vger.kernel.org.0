Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53638634BBE
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 01:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiKWAmN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 19:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiKWAmM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 19:42:12 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B259C694C;
        Tue, 22 Nov 2022 16:42:11 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ci10so8419804pjb.1;
        Tue, 22 Nov 2022 16:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBgNP0HxZqEmc/2hnmKVV8WQI9992gjmzgYgDwpjSpA=;
        b=AMxaAaqozpiEIqVSD0dnERL7aTmBQ+mWEkbAkNKt57+j7WUWbOEYANuBlKIshObE7V
         FtRNcmRfpQYu6RVscVuW2wJEBjLW/APviQcpCqWhkRfWEQbpHb4RHBx8DVhAfXLdkopA
         aRY2Qoo9/iB/mo9wd3jZIQEmr8ohNIPISRDiSLNpj11QoG4igApiy8SZHr9v9WDcCGsC
         68dZNoVEPocgQXaf2sxmHLlRqBCrimoKD5Ou1+/f60sQl1M42NS7+c/0iLX50G1I0TDl
         XUqkCueyjZdyoaITTPMSK9NwX/FsmV8feYdp4Opfi5pulqkKp64DsutTrOBnlwqLrZh9
         hXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBgNP0HxZqEmc/2hnmKVV8WQI9992gjmzgYgDwpjSpA=;
        b=dUuqYn0IwWcjL36NDFRLhZjCFAoSyPFw/lDGeCjBhCcJZGG9rfbLfK5g7hXBux/uNq
         JsNCFjUri99OCzoAuwliTvxd6F3kadaSKfXYYSmECeNEvvflTHl9eHfmzBxysY9muwRH
         67eULtFnvAvam432fZZgmi+qibPKhCh5Ma6DpOYbvU7O5qlNPT64yncsH7Y56NOAy9Qz
         3D9pXWyC9/eveT+t17nqtKntUGPJr6oiKI4VY3U7FrlsZK9mZGsYg5ehA5Ro4/GUF5zZ
         32CmxiI+Qk74sjIlpgedRDroo3LDJwmI9cZDUhw7FlYnVY0cfHqpPZWe7nmo6LK/P/F4
         7icQ==
X-Gm-Message-State: ANoB5pni58bRZBo6RJ7ilNHmYtYkG+4xb/YXDwwkozt1/yHQBBOgPoJJ
        RjndXHZoVwoovCKF/PL26LFi+oQgYGM/Yw==
X-Google-Smtp-Source: AA0mqf5wgPBRdjuuP93HssD4zaNUMxkHa8K5eiih1KIyB+W2rPjrQuf/xN76KD3YRcU4P7gVzd/OVw==
X-Received: by 2002:a17:902:b908:b0:189:1ef4:237b with SMTP id bf8-20020a170902b90800b001891ef4237bmr6869149plb.20.1669164130654;
        Tue, 22 Nov 2022 16:42:10 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bb3])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0016be834d54asm12656101plh.306.2022.11.22.16.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:42:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Nov 2022 14:42:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
        josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
Message-ID: <Y31sYFdA2lHIvjt3@slm.duckdns.org>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
 <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
 <3da991c6-21e4-8ed8-ba75-ccb92059f0ae@huaweicloud.com>
 <Y306xJV6aNXd94kb@slm.duckdns.org>
 <1f52ccb1-c357-a2a0-ef9d-48d7e2eb51f8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f52ccb1-c357-a2a0-ef9d-48d7e2eb51f8@kernel.dk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 22, 2022 at 05:14:29PM -0700, Jens Axboe wrote:
> >> Then match_strdup() and kfree() in match_NUMBER() can be replaced with
> >> get_buffer() and put_buffer().
> > 
> > Sorry about the late reply. Yeah, something like this.
> 
> Doesn't local_irq_disable() imply preemption disable as well?

Right, I was thinking about spin_lock_irq() which doesn't imply disabling
preemption in PREEMPT_RT. local_irq_disable() is actual irq disable even on
RT. It should be fine on its own.

Thanks.

-- 
tejun
