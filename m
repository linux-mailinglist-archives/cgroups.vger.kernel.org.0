Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6DD596382
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiHPUJS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHPUJR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 16:09:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C877C75C;
        Tue, 16 Aug 2022 13:09:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso10673254pjl.4;
        Tue, 16 Aug 2022 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=7SZ5VenNztRnLFMOBFO6xbar+Rfw+Z2OdJF35tqn830=;
        b=Sv5fxKlBKbSA8SlxCHfQb1M2em94RKvPRcxL/wwLsjCiAN9/eRlU2+H9PV2e2/jKmD
         FBkwSe5eyT2dPJlpma0nD6U5hNSdQgrvOMMFC6jGBSn2GAr9ui2aF8fvi2nLhtknnxKE
         vF0C5HXVsbDGUO/556VYSl6E0FcV19MaVH3gvZsuF5E2u0HMdiTo2Y1nw+aI0hUHIrTw
         fvpbvoGZHzZa9q4u0qGZ/j6sVHQQB8WbQNH+Lp5Au+zorDBqIYDqLJHT/vo1duT0llkw
         R7I7c7y0uLpd9mwmev7S3VPT9jz1MSFJT0lBN27Es5G4/kgqezl4EaGzn5edvG3mnMK7
         T46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=7SZ5VenNztRnLFMOBFO6xbar+Rfw+Z2OdJF35tqn830=;
        b=vpuFpOrzcnEJ9pjG8xf+L6MsCBl1NrL/hArxjXl0fzycy2vP4POX03hk+HdzuCiaDf
         NAAOSPw0/ZW0AjdstduSExPn3Yiu0Nl39QVd/Q4vJpLz2IWruQcHmaBFKnxxpinG6VgC
         /Lyns/FOXCEWnZ6rWmlNIAwc8zOVthm6vneNKHHlAfFRlBSCh1yH3bHS9hVRMAJP1hIg
         Q8DDuc/uOX5OisH8OQwi7ToijLkratRZ0dqM/LadnrTgkzULonge9uSjWg1ESKmvZSrd
         rmOy29+jsKxV9AysGWuCd7bT3S9aLGTusDy7M0Z8UE1rMnd1/aJZpdC0VDZ77d2JFlfw
         6aow==
X-Gm-Message-State: ACgBeo3JjZIVe5WKXPCixYBWyodE53IlqCS/vT83RfyM2PPGrpjFHsOa
        9trRRnV/Eblrza2mgiaUIZo=
X-Google-Smtp-Source: AA6agR6YCr4etjg++NmjN1lp2khS9VxHoMkwP+8i3D/ZE7Rx+vY/+uxshYzCtOo8mfsuFa6yoCtHsQ==
X-Received: by 2002:a17:902:d885:b0:172:868f:188c with SMTP id b5-20020a170902d88500b00172868f188cmr3512048plz.78.1660680556322;
        Tue, 16 Aug 2022 13:09:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79686000000b0052e23a5ab74sm8907315pfk.59.2022.08.16.13.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:09:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 10:09:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v7 8/9] blk-throttle: cleanup tg_update_disptime()
Message-ID: <Yvv5as5BVuqjw6PX@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-9-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802140415.2960284-9-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 02, 2022 at 10:04:14PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> tg_update_disptime() only need to adjust postion for 'tg' in
> 'parent_sq', there is no need to call throtl_enqueue/dequeue_tg().
> 
> Save a little overhead in tg_update_disptime() and prepare to cleanup
> flag 'THROTL_TG_PENDING', there are no functional changes.

Does this actually help anything? Given that the heavy part of the operation
remains the same, this might not be much of an optimization. Is there even a
microbench that can show the difference?

Thanks.

-- 
tejun
