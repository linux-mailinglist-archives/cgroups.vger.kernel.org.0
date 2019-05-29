Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17212E508
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfE2TIv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 May 2019 15:08:51 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:45321 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2TIv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 May 2019 15:08:51 -0400
Received: by mail-oi1-f182.google.com with SMTP id w144so2966369oie.12
        for <cgroups@vger.kernel.org>; Wed, 29 May 2019 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9M83j5VgZqnbq4QKIC40z5RykjHLdbDcFYqEBFQAM9Q=;
        b=BgnltxIEsPclx/Vr/vTO+Gsl82dS1ePz6T2lP33ZTGsNESYjGtxIeObAnRKRmFAxOA
         Y74UbJTVWozTlkVex8yk1ziJ9mntkDto672j/G+Jtq1KcPlxdkM8kwH0tqXPesKj1dpF
         YxZobEBmWukUm2HLt5X+VxhllyQnhcBY9RLLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9M83j5VgZqnbq4QKIC40z5RykjHLdbDcFYqEBFQAM9Q=;
        b=kZ1uGfoIqPgBC8ycdGDvsV8FlfzjwK8t55hc2a1X1WLPoNxNkq+ff8rDUSwAVfQIxy
         e6oFShlc3p9AZvG1CSDtBiKWmW8dEKbCZv7U0i0qZeHPFA8Icyh9d0Hr1Tl572tL6U3c
         eoZoM2M8Zjc49hqjCNAKfhSPntUtKjUhZTn39mb3xvo6BQIUxj863Cj4BBymHkECcKts
         QtZ61H5PdXPDUoZ0YyRLGsl8HCWVdHNqBHK2LrZYqRa8eY+0lIhcp/riBfOoVKiUALm1
         36YFnMFg//Bjv4jQgWJCnDuPFBb8s3ez54V96E2MD4tg8sn3E+8OG+jFDu+6whOxzwg7
         Yx/A==
X-Gm-Message-State: APjAAAXyGHa5i7A54FkWxpATZ+LXEKOT7g6o6vZL5ccO5kyBeSFDtAne
        YzdXNfyop9p508w8EgBemb4DEQ==
X-Google-Smtp-Source: APXvYqzK9c3JqRxvkrNr7vtfvTca6Y5lZHCWWdpg0BHow713tvjHfGSQqtezy7/bI8OVhP01rgLxXA==
X-Received: by 2002:aca:ea55:: with SMTP id i82mr7421001oih.33.1559156929781;
        Wed, 29 May 2019 12:08:49 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id w79sm136935oif.4.2019.05.29.12.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 12:08:48 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v3 0/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
Date:   Wed, 29 May 2019 14:08:45 -0500
Message-Id: <1559156926-31336-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changelog v3
	- Reworked documentation to better describe behavior of slice expiration
	  per feedback from Peter Oskolkov

Changelog v2
	- Fixed some checkpatch errors in the commit message.
