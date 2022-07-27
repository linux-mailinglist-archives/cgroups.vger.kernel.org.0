Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F45832FE
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiG0TH4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 15:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiG0THf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 15:07:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D00B0C;
        Wed, 27 Jul 2022 11:42:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c139so16878169pfc.2;
        Wed, 27 Jul 2022 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=AmYRhi+bYnf/7wctVUfLsHYE6jk09n50bYSccxZQAcE=;
        b=OE3lt+DEngtZX5hQ1eQWQNZKJeRw2G3yBic79b6g6GTefs4pdXaH7cEN+ijBdjD9zG
         /DD2kp1I7c3OL1lehoNgpPpnlO2WCkmE/pRAF6ll7AjOt8mvKRBsQpXZSxf3gapp/NkN
         Vsi9i2dgzbTa//cH7XWoyBsPNK2xx3j3Xjm9nJ2FozUM3g5smsguvTrtSbsWz6uHFi/o
         2Q33sLUGcoS9Ooet2vT8Ny6vsIheqGO10LTdnNsS7aqOKqIzRhKgkphgPxDYnsukm8ju
         90JnyDICSD2NEQx+oO8qtwkAiRCI/LNB9sFz+1D2vmtl2oIQoKHJGxyTwSchmNZsNtjb
         F6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=AmYRhi+bYnf/7wctVUfLsHYE6jk09n50bYSccxZQAcE=;
        b=K9usCyRQwUfXclXDcwsdSkNn2R3ihTJfW/3OTcgLBmVs7opSO6Kha1jzHtoN4ZFw2I
         6s365svDipD43BwcU+adM6Td+/gdqKb5bcejYCdvxz7l4QUQwWARDn94Iw0dg2kTh1Xz
         OHoqJyQ/RUK/JURqQVGdJgUbwYaSoVRwjRfLIrqjLu9/76nxgtqujiQOu0hKQ4y6LAdm
         H1LxErBn2cv2eZLvZ/dSzkX41swyM/Hr9COf5kjuwAi1c5RpVgd24DygmTrClE1QosxJ
         VTx1ZrmJZBQQ9Jgjx/PyroOhSgpaCgt60RnYxC9ONGeM5wZMiONSfRThyjSSh4caUegK
         0TxQ==
X-Gm-Message-State: AJIora9O8k1SC9JOvM9Qi+GDxtvp+lnkxvTVB0YW6Bl6/6q8vqSpuZMl
        jENTmsHTPMHggt0NOAzjP3w=
X-Google-Smtp-Source: AGRyM1tw8+30zp6/LmyaG5yQxWTto8Zf0oIWsWzmKjASFnZSgPXBmT2QCNj8455RcP4Bku+FVeOKMw==
X-Received: by 2002:a63:8848:0:b0:412:a9d9:d405 with SMTP id l69-20020a638848000000b00412a9d9d405mr19321286pgd.384.1658947376416;
        Wed, 27 Jul 2022 11:42:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b0016dbe37cebdsm450404plg.246.2022.07.27.11.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:42:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 08:42:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND v6 7/8] blk-throttle: cleanup tg_update_disptime()
Message-ID: <YuGHLlBw55lBx1IE@slm.duckdns.org>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-8-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701093441.885741-8-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 01, 2022 at 05:34:40PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> th_update_disptime() only need to adjust postion for 'tg' in
  ^                         ^
  tg                        needs

> 'parent_sq', there is no need to call throtl_enqueue/dequeue_tg().

What are we gaining / losing by changing this? Why is this better?

Thanks.

-- 
tejun
