Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457ED3E9722
	for <lists+cgroups@lfdr.de>; Wed, 11 Aug 2021 19:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhHKR5G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Aug 2021 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHKR5G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Aug 2021 13:57:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748F6C061765;
        Wed, 11 Aug 2021 10:56:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q2so3654898plr.11;
        Wed, 11 Aug 2021 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ISDCxbC0OsTshs9YdIziBnJ7D+uMqsu/ILSt9X0dxQ=;
        b=XgJVt0h7y/te1WZ+8bc+lSss2d6dT6f/ugcIJg2cTf/YeEo0GnUA1aKpj4BC5CORUX
         IOOGZou+zCoGZoC9Jy0WPjpMV55jn1hTTYb5UI9ICBZs81sHplWjDcQcOXdlhJC9LBkz
         CTRNFnLHL6b2ge3AZaSjg/+MOXrltfyEPrQwMksqCcnyRiJNgYGId0LN5JwZnfky3sWQ
         ByW5Ba58LNtePDFGhHyQDObBzc+i8ET2DLa24ktyM64RKPY/fqNKtHbL8X25c+06iy+p
         q7JK9FNPoTxfTuHFxDvuljwRJ8IPlpZgASn7KThKsWs6/q7+uHWUXPEKt5gZ4Sgbk5Ej
         T7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3ISDCxbC0OsTshs9YdIziBnJ7D+uMqsu/ILSt9X0dxQ=;
        b=pXOBGqFqnYhlBsSDGKqxM357+j3g5bIxmQqWaqW2OwvSPEg8zPwK/MIid5v5XZwd5j
         qqjfIQahz45s2Jnkeusc7AajvjOq8JwpoKhMAHcarmSU/WR38EMIERcrjt31MN8LZs3P
         m5KNlpK5cYNyD6dENnghMJGDSlQcxJcCfNOy7BmWdlEgdfaalg8VqAo+JY7oCiFMilVd
         qicj9EcC19HFaXPJGNdUVO9xEkJBDRORo4IQWke6FtIKPhLFdZjVEeijUKShcO2r5qpT
         YR+bdgA00CDOgrw5p0mpkxEwR3DLPzEDpNedPdCQKuc8gdzDE/xKgkf2x8JMCRolJwf1
         vyAQ==
X-Gm-Message-State: AOAM533d7Aw9kzvhlvKFt4Cecy0cMBrvqPkBbAOdGKUiaThHoe96c2Tr
        pF0rPsmbStaS7P3S5E2F418=
X-Google-Smtp-Source: ABdhPJx/OqmZLf6d3VJtKQdNcsOC0tZuiq2fGHOLzxXOdEQ/F57I9l1XJ6aoQMNus7lfJT+nfzdABQ==
X-Received: by 2002:a17:90b:4016:: with SMTP id ie22mr38995509pjb.68.1628704601893;
        Wed, 11 Aug 2021 10:56:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j128sm175779pfd.38.2021.08.11.10.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:56:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 07:56:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-cgroup: refactor blkcg_print_stat
Message-ID: <YRQPWJS3LVbiubs2@slm.duckdns.org>
References: <20210810152623.1796144-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810152623.1796144-1-hch@lst.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 10, 2021 at 05:26:22PM +0200, Christoph Hellwig wrote:
> Factor out a helper to deal with a single blkcg_gq to make the code a
> little bit easier to follow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
