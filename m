Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9167588BC
	for <lists+cgroups@lfdr.de>; Wed, 19 Jul 2023 00:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGRWwj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jul 2023 18:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGRWwj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jul 2023 18:52:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F17812F;
        Tue, 18 Jul 2023 15:52:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55c85b4b06bso3482133a12.2;
        Tue, 18 Jul 2023 15:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689720732; x=1692312732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaaIJSqrG494B+IR6XnJYhrqBHMp5GMdu1zHCLyiGYI=;
        b=TyD+VnTKX9Bn+aYMr/dB4EhK/Uv4WMA+GewMLDH1kkehkeagP5XXmyA4q1DIVNjF3w
         YxT6kyspFNoSp+guSUo2bO81uzyI0lZJ+VlptYiffxLFEgGHupE4u00n21/1oim5FOnW
         ZSX3QDpgEAcqrqRIZ7rXXuSk5MzJEPdgdYHRIhquAr2s6TAyxY0dwlzMyns6B81gKmqx
         96TGy+fOwRGp7TXa44C2xpnSvvxyoQO3I2XXNHfq5k+pkwj0FSb71OJdbiX+sdh2QNY1
         PdJtghSOsIK0thkDKiKWV9YT/pqfhdlDjqnf7acWiUWLLCBEfmoQRz6aG2O4ndwGXhY9
         kirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720732; x=1692312732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaaIJSqrG494B+IR6XnJYhrqBHMp5GMdu1zHCLyiGYI=;
        b=SjmROMH3IVFiTAAPrHo3FOC+ZSRwmCYxjuZXzejimlixGQRMPGntL+Aiib+lp9nQN3
         PyZpEL6qZIAZj3NrvVd2ha/ivYKyTB5e+0BL4QdjzPa49RhC1+Vy+iDIiVLqQxGtN4QC
         HLGaa8+peg+y12u2zdsYxCpASq/cGZB/6CsDYO2y9a56zHOxGG7xXGvKlb9vJIzIAPHx
         iYpRJPa6ZlWgJmVDPK14TxrAgF57NsOMZQoagRKRk1TYN4lzeTHASBorVkB+IBOqlxKn
         tb82uF0PllD1eeuwuInWbFRK3fitXW6tj60i70TBVAauemmg5/GOhQc6uE4+PRl0QzUc
         fTzQ==
X-Gm-Message-State: ABy/qLbhtAAoagAwfQjlksmwcKZG5aLDM+Ipm6oXrn0JrRv9aHGUwIfp
        c9PX/YVScbjoBbR+TrRIJKw=
X-Google-Smtp-Source: APBJJlE5rngX5nDgVJO4NvR0EjzzcP4AxHZIl2HrLcWOA0ALnr22qACdnLMrMkY2G6WmN1hOst1iow==
X-Received: by 2002:a17:902:c945:b0:1b2:5689:8686 with SMTP id i5-20020a170902c94500b001b256898686mr15146093pla.63.1689720731910;
        Tue, 18 Jul 2023 15:52:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709028f8f00b001b5656b0bf9sm2344653plo.286.2023.07.18.15.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:52:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 18 Jul 2023 12:52:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, vipinsh@google.com,
        kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: Re: [PATCH 2/2] cgroup/misc: Change counters to be explicit 64bit
 types
Message-ID: <ZLcXmvDKheCRYOjG@slm.duckdns.org>
References: <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
 <20230718010845.35197-1-haitao.huang@linux.intel.com>
 <20230718010845.35197-2-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718010845.35197-2-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 17, 2023 at 06:08:45PM -0700, Haitao Huang wrote:
> So the variables can account for resources of huge quantities even on
> 32-bit machines.
> 
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

Applied to cgroup/for-6.6 with some whitespace adjustments. I think the code
is broken when we cross the signed boundary but that's not a new problem
caused by your patch. I think what we should do is to treat atomic64_t reads
as u64 instead of putting it in s64.

Thanks.

-- 
tejun
