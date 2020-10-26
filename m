Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32462298E8A
	for <lists+cgroups@lfdr.de>; Mon, 26 Oct 2020 14:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780739AbgJZNyw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Oct 2020 09:54:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40831 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780738AbgJZNyv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Oct 2020 09:54:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id h140so8325272qke.7
        for <cgroups@vger.kernel.org>; Mon, 26 Oct 2020 06:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cUT8Sy01NVeG6Z9oLzP8fHNeZqNa1h3Q4yE9nUY4mH4=;
        b=JXg5D7kCFBJVxLNDC5x4JSkTHc61NyFYC3pf51a28Uv1bIRisaqXT1bZnliDg7imPi
         i1xRI/jErcJTEwWCaH5uwXGu3RNOgcCp0E3J5qTxcaVo4XhGkrPwUCD3XvIAVsbMlPHC
         jZCFEsYQMUnucPPS2aX3zB2UY+++ii40fgWqazFVBdkTeb+cK2igw5nK3cwH8fUIXiqP
         Bf9WwT2c2nxrkYFHA8lPvHgWTvwHN5SzXSxo23PRntPWSv/spgvXujUUvA9Nj6mPjIVS
         otj4l69lLd/fpc9/jXA05QHVmijiNc4fj0LY6ejw8NnXTKogmHgTPQ4sSrAMqY31OfP3
         vnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cUT8Sy01NVeG6Z9oLzP8fHNeZqNa1h3Q4yE9nUY4mH4=;
        b=F+sxov28cwq8N2UXaGcx7SfRt4Qf8uF7ePO+Md5WukDZYnBXPP4I7Oy5bvIbB2jwEC
         45WCY8Yz6cW20dahx4bIpmMbz3M3M7g15fOotjoFoQIYlun2D+8C6rMa+bwXOmLJA3JE
         YSy/gWWduW3YVpCaxayrBfw6C7SMVHDxrYR9NAwQ5nTfwlBpkZ/f1v5Tv9dz7j+GtTqZ
         92VLUrVVIfF20AcgiyXIfy2LMq6950NZndcGjKw6yesi/Dmnu8+44WMnVWi/2qAGlluD
         ndeAvynUyYb4r6vjInDSZhultgaqsRJCrTVNTL9/EiWmC8z5L+yskA1UPsbh1hkLlGW0
         5Clw==
X-Gm-Message-State: AOAM530Vz1y6douDMpf7vNeXFscN5cI/W2/p5pXnE0jMYypz+mEWhSIX
        7ICd9xtKIdgGXFcgLPEVoE4=
X-Google-Smtp-Source: ABdhPJz96cr+pJFZHbEbHyPMy2YN6HUPQ6Ju6wTh7YvlFRT2+2REaeqlznkyadvdDHmVek6qZAGI4Q==
X-Received: by 2002:a37:6855:: with SMTP id d82mr15970612qkc.461.1603720490519;
        Mon, 26 Oct 2020 06:54:50 -0700 (PDT)
Received: from localhost (dhcp-48-d6-d5-c6-42-27.cpe.echoes.net. [199.96.181.106])
        by smtp.gmail.com with ESMTPSA id a128sm6404545qkc.92.2020.10.26.06.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:54:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Oct 2020 09:54:46 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org, khazhy@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/2] blk-cgroup: Fix memleak on error path
Message-ID: <20201026135446.GD73258@mtj.duckdns.org>
References: <20201022205842.1739739-1-krisman@collabora.com>
 <20201022205842.1739739-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022205842.1739739-2-krisman@collabora.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 22, 2020 at 04:58:41PM -0400, Gabriel Krisman Bertazi wrote:
> If new_blkg allocation raced with blk_policy change and
> blkg_lookup_check fails, new_blkg is leaked.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
