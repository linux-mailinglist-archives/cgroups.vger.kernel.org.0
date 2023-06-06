Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5B724D79
	for <lists+cgroups@lfdr.de>; Tue,  6 Jun 2023 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbjFFTrg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Jun 2023 15:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbjFFTrU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Jun 2023 15:47:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB11FEB;
        Tue,  6 Jun 2023 12:46:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-256766a1c43so2932568a91.1;
        Tue, 06 Jun 2023 12:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686080797; x=1688672797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc73F63LtY0R3e3jd8aXo3gZg8F1PNW5E1lmdjRfGIw=;
        b=hN8GRjG/znPgtKtttYBsMmV9UxnG2Wz6olapQ1TKb9pgE6iWFqkxjLqkjj9Qj8x2Vn
         CQVXqppCsf29UF9YV0jlXkdaOQzIqnGuJeDQurXYtKeC1jQ6zz3UZheq33bN6O3NFvku
         gOgfd7b42+0sAuUwp/DG4UMS3jWhZTjWiIJKNv5EAqtVrFuMY6iV6maNfBK2MaJB0/lL
         LfLlxaF+3eG1WYhHDXjz/NFOCX663fAaK0VdmVVFggqXCVkmTvArZMIHsxDQAddNbadr
         z67f+Qa2RcNVvJ/Wxq4v7/NaQmdwDCPKIaLDwPx8Wge1Hdq6Bk432nH8eXjN1JFaHMlO
         w7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080797; x=1688672797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc73F63LtY0R3e3jd8aXo3gZg8F1PNW5E1lmdjRfGIw=;
        b=Y8JAz8k1obLs3pOGjJmYV82o/g/9joUM/fWH5P7AbiqzfnKmjZUoHYokulzdnsob6C
         FGMJYfU5BnZhP7jhCstTcqrCnwTtKIWnir0n6HT1K8Fw0DBU0+/RA3RIdSQA4Q4Q6Lj+
         ULSGOBDDIjuPWyCv12C+KDynpMB4u8tv1D958xviQA1wKR+IXmkjJTfEpbTTcxSf90W1
         jBNjB3LseqWNtEP2+nmDuTs1k0nswsTaxGOWL8OnUBYHWikQR1Z+KEgp9hTyfhu9xwUn
         MsH6FL3Wajwwt8gCVvDAqGxb+eBYc93AYxohawv/eMBevK5yRE3eJYnc2OBpU2COCYwc
         WmdA==
X-Gm-Message-State: AC+VfDxjm8Z5vDa0JtaisQUPvv6gWH5714CKkOKwNYnpJ4Dgd1aOdD4d
        2dAybnHGnRuEQFK7BrxzRAi89blgucE=
X-Google-Smtp-Source: ACHHUZ6SKvBYBzApfnEcdlEgSg4bIwA7p9LYrDeqqZzbciXr9vBHNV4hoNhYvgtR+6JQ4NNFaCs6bw==
X-Received: by 2002:a17:902:e74e:b0:1b0:74f5:beee with SMTP id p14-20020a170902e74e00b001b074f5beeemr2001106plf.34.1686080796913;
        Tue, 06 Jun 2023 12:46:36 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001b24857d1f2sm355479plo.188.2023.06.06.12.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:46:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Jun 2023 09:46:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-cgroup: Reinit blkg_iostat_set after clearing in
 blkcg_reset_stats()
Message-ID: <ZH-NG5VFl3dpln7A@slm.duckdns.org>
References: <20230606180724.2455066-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606180724.2455066-1-longman@redhat.com>
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

On Tue, Jun 06, 2023 at 02:07:24PM -0400, Waiman Long wrote:
> When blkg_alloc() is called to allocate a blkcg_gq structure
> with the associated blkg_iostat_set's, there are 2 fields within
> blkg_iostat_set that requires proper initialization - blkg & sync.
> The former field was introduced by commit 3b8cc6298724 ("blk-cgroup:
> Optimize blkcg_rstat_flush()") while the later one was introduced by
> commit f73316482977 ("blk-cgroup: reimplement basic IO stats using
> cgroup rstat").
> 
> Unfortunately those fields in the blkg_iostat_set's are not properly
> re-initialized when they are cleared in v1's blkcg_reset_stats(). This
> can lead to a kernel panic due to NULL pointer access of the blkg
> pointer. The missing initialization of sync is less problematic and
> can be a problem in a debug kernel due to missing lockdep initialization.
> 
> Fix these problems by re-initializing them after memory clearing.
> 
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
