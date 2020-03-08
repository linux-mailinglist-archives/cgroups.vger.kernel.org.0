Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3905417D0FA
	for <lists+cgroups@lfdr.de>; Sun,  8 Mar 2020 04:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCHDQk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Mar 2020 22:16:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43318 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCHDQk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Mar 2020 22:16:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id f8so2568810plt.10;
        Sat, 07 Mar 2020 19:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Nb+0eCJ+RmZWTIi/A28JTvkScuDbfRdl791J3v1ybU=;
        b=gyNFz1js4P3o2fO/Z1TjzVYoqZoqx1LLxetnlManqDFo7XnMcpxZihlmGqOGBDbrbo
         77+5HSZQ5rEo9o06ipb2DYJpyy97T/f8n8DI1fK/AxVr38p/w5nREwHd8W0C5mwYbo5N
         fKAq9qk1qOmVlHcc3vCwUU6TJki/1mKOkx5PkdMBkke4PCWhtz6MF5DjrQgBY4aOKiJK
         bydU0stJCgmMNFiH3vYn6FxdnIhqm8Z2DMGzuuUhNRQV8hLpq/8Y+fqCXmanPBsyFl+o
         Izra9FkQJisCTFoZ8wuvbg5xqiSD9QehRlKbVOeXqaQbCKuNqxaJvcH+e3kFUa//u061
         o3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Nb+0eCJ+RmZWTIi/A28JTvkScuDbfRdl791J3v1ybU=;
        b=ZBzKWsVw2tIBxpDCUZtFfm/NV6YIUzrQQnzHaJSI4jG0LPKtbS98gC9tIOApR26soX
         RLCSTiMbIE2bFxJJ3mIqU5Yglorp3kMgA58Istz4w8ojkqw6qL+y27zDFPkZlMoLE33t
         A2j4s+HUi9ompNW2jMfoa1psZ9ZXhTOZVIt9HCUTiZi0RcY6j+hmjlxt6d4oz3bwvfN5
         YYWfnDTommixe+8XqZE72xe12TYXhhoc1DMGYImt0Ig//XZUPuXwg+39SjVJPOdz5X4u
         WHc+XWP+2/Mwpv6oWrghkSheztmutZDLQhR37MYeOgnBZtfh4wYvBBOJEvEs6BrQV0Xx
         8Ibw==
X-Gm-Message-State: ANhLgQ2yCMMJyVTAYGdgze8N60VR3bF1TIdeuBS6+3+juSeeM5IGVtI9
        yD3tPcgKEZs7d0dOoWNAEOI=
X-Google-Smtp-Source: ADFU+vts8NPW5NBCO1lUnAWQ7WDcIE6VGZBSRZMrlz6A1oA0ssnEhcatOqsJVHJlRZxqXyJO5QQeDQ==
X-Received: by 2002:a17:902:8d8a:: with SMTP id v10mr9810813plo.90.1583637398563;
        Sat, 07 Mar 2020 19:16:38 -0800 (PST)
Received: from localhost (194.99.30.125.dy.iij4u.or.jp. [125.30.99.194])
        by smtp.gmail.com with ESMTPSA id s18sm13679394pjp.24.2020.03.07.19.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 19:16:37 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sun, 8 Mar 2020 12:16:34 +0900
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: Use fallthrough;
Message-ID: <20200308031634.GA1125@jagdpanzerIV.localdomain>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On (20/03/06 23:58), Joe Perches wrote:
[..]
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -424,7 +424,7 @@ static void *zs_zpool_map(void *pool, unsigned long handle,
>  	case ZPOOL_MM_WO:
>  		zs_mm = ZS_MM_WO;
>  		break;
> -	case ZPOOL_MM_RW: /* fall through */
> +	case ZPOOL_MM_RW:
>  	default:
>  		zs_mm = ZS_MM_RW;
>  		break;

Seems like missing fallthrough; for ZPOOL_MM_RW?

	-ss
