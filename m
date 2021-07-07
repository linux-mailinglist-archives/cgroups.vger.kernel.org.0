Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB303BECD4
	for <lists+cgroups@lfdr.de>; Wed,  7 Jul 2021 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhGGRLg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Jul 2021 13:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhGGRLf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Jul 2021 13:11:35 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17072C061574
        for <cgroups@vger.kernel.org>; Wed,  7 Jul 2021 10:08:54 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j13so2678894qka.8
        for <cgroups@vger.kernel.org>; Wed, 07 Jul 2021 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zKFzxaicRuEWN6JDVuwxf/5fHNRnvOJNXCo8RqlfnUo=;
        b=K07Xb99QcriEOisR00l22wLQPQEOIpOXNJAf9NhgVco/oZ9jwUnQ0BR4m/V9l2aVu3
         7Ue85P+ZxUFOf7SP+RuJxDYfEyBUPkLCBoJ2Tbjlh0beKAnJ/INjxQ6Fkx+jJqhYaVGT
         RjMT0XF4LKj/9H7bu0nqsgCsRncfO3IsCb6RKkdDyvHJKow5YHLgaVkGWPoyOig8rF7q
         u37fNGzarIMgfy9mJlnW7SqjOVYt3o9RJ+FxXglVlM5PGmawY/NT4yBDQxiPBNUMYhNM
         7eUk/7LFiyrGoo6WBmJpGhK+MbzOdBSwOgaZRXJY+665Xnpq9Ws4ZIiUBCaYBAKXhqZ0
         Bv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKFzxaicRuEWN6JDVuwxf/5fHNRnvOJNXCo8RqlfnUo=;
        b=ZaC1Nmn+h6JLMWCdeYBpziienvMF5d7g4CkOCEki2Wfy4NXghPdlTjdpynC8YgXzu7
         Ifls3q1D3PT2cT9e7bMUEzsUw4jIf8uhCkbOQ1REJJEJ73UisG5Uot85+5/CuMgO9b54
         y3aCtLXWh/KZBrJEdkoW4vzvzm8ux0xALwrd76x53X4Hl26nWkPXtFfHSMjds7EVp0pw
         nasn6r/6g+Ca8uq4GulbbkmdNS4EvRF/d8MZ111Rn9hJDFsttRniOSTIWVRSPAJMRYqF
         4u7ebSTR4H7xqWOznDs+s4munDjnOSjaOF5Shz+/ogGHQ/WYIetXV0uhhsooCv0WsLav
         Rx0g==
X-Gm-Message-State: AOAM5311XtMz9BD+b/F9kJ0l5mqGxCsi7VP542hSLjywWVqcZnmrMYnK
        NDWNp6AC4HMp4HZ1VCFBTiJPzQ==
X-Google-Smtp-Source: ABdhPJyvpaXGsh/M091lO5PbRxD+WGM/34+NjN7awp7C4IyKjHFJo9WpZyAbacwM83XKvBQQYw8UWA==
X-Received: by 2002:ae9:e8cd:: with SMTP id a196mr23914727qkg.225.1625677733331;
        Wed, 07 Jul 2021 10:08:53 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id g1sm8474122qkm.58.2021.07.07.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 10:08:52 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:08:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 13/18] mm/memcg: Add folio_memcg_lock() and
 folio_memcg_unlock()
Message-ID: <YOXfozcU8M/x2RQ4@cmpxchg.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-14-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:29AM +0100, Matthew Wilcox (Oracle) wrote:
> -static void __unlock_page_memcg(struct mem_cgroup *memcg)
> +static void __memcg_unlock(struct mem_cgroup *memcg)

This is too generic a name. There are several locks in the memcg, and
this one only locks the page->memcg bindings in the group.
