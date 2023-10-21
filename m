Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993427D19E0
	for <lists+cgroups@lfdr.de>; Sat, 21 Oct 2023 02:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjJUAXA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Oct 2023 20:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJUAW7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Oct 2023 20:22:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B79D6F;
        Fri, 20 Oct 2023 17:22:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9daca2b85so10894995ad.1;
        Fri, 20 Oct 2023 17:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697847777; x=1698452577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8csCcqyPHN70OIAcTNByKOiiEN1AgXGu+ekIk5zwHk=;
        b=NQltEtuWeprwGPNFmRm5v4J2x/mGURgoNBkm9XwxwGSAt2QaUtzjSRG40st9Z+AYJg
         K/vlRdInkqhmApDisJ++ME4p+QSpO/Rr1S5FqYQgVpvNO/jxqs/k5LwUvqw5V0o3NBNd
         dy1w0UOhmha5K5+egMKhOI5SOBUTBAagx8lYDAnhi5NU/ZfZn9Jtb9MHJSolGzE71TPM
         ZoGvsONtQ/EfEbemldgdO/M806zlG48w39rg+bz3P/tS0KhGoiuIGouhYDZX+wUm8/UJ
         /6Av4bq2qLdy3f2rX67DYxn45c5EkkcWKBpBEcUVx2NWBcdeD4aSwUjsQRnZaWp+3F/F
         SXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697847777; x=1698452577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8csCcqyPHN70OIAcTNByKOiiEN1AgXGu+ekIk5zwHk=;
        b=f/pz1DgjCBc8m1aLx7eVzvrOCE6iN3TdhSwkLwaXlL+K8qAuK86sZ/fyofdO1uChxj
         UqSCiC9SgMvfflh8eiMmeh1EhIOiTpODR9ONjWre4oN45C/FEb/ujXSw1jaIZyB8qZdw
         j816wDwUR/x+eZ3DwievnrPoZ1wK1h6WNTwXWYCPcJ3Tk+fLPOogJrWDGDIXTs9lFqK2
         dV8fsClzE3/Xvk1GqTD2nqZ6d0Vkt0MiIAE+re3Iv9e+1Fe3JBV+DyHvrJZA6fT3YXqE
         Mm94wf7ztxCNbiQxjWpYsWGwtxpDi38fmfxtrU4ILOZ/fNdKdfAWeoDYBo+WLK8BmGK5
         SAlg==
X-Gm-Message-State: AOJu0Yz8BJ3lbCFLzXgtTf22SQUZcwIXA3HVMxNiD+U6gytBLYcNN+MC
        95nKgFZWjFZx9mxtjqVOT9M=
X-Google-Smtp-Source: AGHT+IHl4cDpMdS+msHDwp9Hd2ycipZBByb1z2hLNQf1gb3LrZi8K0JuoHhIEIeqL+vQvblEvGzhOQ==
X-Received: by 2002:a17:903:189:b0:1c9:c879:ee74 with SMTP id z9-20020a170903018900b001c9c879ee74mr4694936plg.26.1697847777088;
        Fri, 20 Oct 2023 17:22:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:a906])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902704100b001c61921d4d2sm2060761plt.302.2023.10.20.17.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 17:22:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 20 Oct 2023 14:22:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Khazhismel Kumykov <khazhy@chromium.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai3@huawei.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, linan122@huawei.com,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH] blk-throttle: check for overflow in
 calculate_bytes_allowed
Message-ID: <ZTMZ3nOXHyv73uvY@slm.duckdns.org>
References: <20231020223617.2739774-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020223617.2739774-1-khazhy@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 20, 2023 at 03:36:17PM -0700, Khazhismel Kumykov wrote:
> Inexact, we may reject some not-overflowing values incorrectly, but
> they'll be on the order of exabytes allowed anyways.
> 
> This fixes divide error crash on x86 if bps_limit is not configured or
> is set too high in the rare case that jiffy_elapsed is greater than HZ.
> 
> Fixes: e8368b57c006 ("blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()")
> Fixes: 8d6bbaada2e0 ("blk-throttle: prevent overflow while calculating wait time")
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
