Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84912CD57
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 19:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE1ROW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 13:14:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43193 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfE1ROV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 13:14:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id u27so15205368lfg.10;
        Tue, 28 May 2019 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WjL1kPJpFZ+/6P/J2gFeO1EXLoFczY/0XpAxesm/SAI=;
        b=X2EOagEpclu4ci+J5hELZN56hZWa/YKEEJMK9pne6v5cmFWQgQ58z6hcuN4SKQZLrs
         2LYlVt5tiD/iE7WqzRZ8jHNm0MmyqhWQEq2iiBv+DbERpI0KtlpIuMTL9yxGXn0AATbh
         8S0dlssbwt0wAe9eMcKuq2YGU1jgdpZYeMbvwqLprQpHN3qxVNgQDU8vri2A537s8p//
         4WiaEtaZRVBk3HrrAySnKiZf7QfTCHiQPbl3Qy0m6tUmkxDUBAoSxoVUsBGbuUEW8WH2
         XoXsVF5Uid2iHAY8wQtjZ5v4ARPAKJRygdV96eXj2QnQS68LlFvJivE/aqEn0j6N9eNR
         yrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WjL1kPJpFZ+/6P/J2gFeO1EXLoFczY/0XpAxesm/SAI=;
        b=J/+7FImhPXpE/ND2s+qd+RP1ihScvDVAGRddoQ0S0eGuhqIdhQIZluUqUzknK6EBSQ
         MK0x7CWQX/eus1Nhwo8eXDfghA9+PdZxzJSpdgTY96z+6UgFsACXDRciBz53sv39AHrE
         2UT1eF5CwbZ0iBT2nEb2dnodkDNs6hoUrJJTON7n+fsbQhExlqJJKO5/FigrUq9vjtnX
         Ao5PKjvhBzw8Nl1ZySYlbMrlXGdml7ZKRwdiGXTsGPPzSXjoDQsY60UDtZHXgFnasw9r
         ng100DKtKR+nJJVrElU8tCqiaKFs1x53B0h9i6VUdj8h50ARdshE6kd63bdEl3hah8Za
         +AAw==
X-Gm-Message-State: APjAAAUR9MCm74hDzr8fsxowI5/adyTi/oKSRmFngW+TlRWXcCCalAHE
        wcGj9Jo0z5F376rCyVCgK3QHFQ4042M=
X-Google-Smtp-Source: APXvYqzDZrteCE2LfMAWo8TQW16K+fLRlpq3FoRftMOd27u43NAPU34bi0T2PD4lughRbHjwkIeHpA==
X-Received: by 2002:ac2:510b:: with SMTP id q11mr4381015lfb.11.1559063659938;
        Tue, 28 May 2019 10:14:19 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id d68sm3014105lfg.23.2019.05.28.10.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:14:19 -0700 (PDT)
Date:   Tue, 28 May 2019 20:14:16 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 1/7] mm: postpone kmem_cache memcg pointer
 initialization to memcg_link_cache()
Message-ID: <20190528171416.ujwr5rhbo7g4wfd5@esperanza>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521200735.2603003-2-guro@fb.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 21, 2019 at 01:07:29PM -0700, Roman Gushchin wrote:
> Initialize kmem_cache->memcg_params.memcg pointer in
> memcg_link_cache() rather than in init_memcg_params().
> 
> Once kmem_cache will hold a reference to the memory cgroup,
> it will simplify the refcounting.
> 
> For non-root kmem_caches memcg_link_cache() is always called
> before the kmem_cache becomes visible to a user, so it's safe.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

This one is a no-brainer.

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>

Provided it's necessary for the rest of the series.
