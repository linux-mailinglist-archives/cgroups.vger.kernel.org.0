Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F46FD071
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 23:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjEIVCu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEIVCu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 17:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90655FEA
        for <cgroups@vger.kernel.org>; Tue,  9 May 2023 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683666084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNiIZHyonT4Lc3v22Wd8EHVvgd0ES2GAsHIl3w6taTA=;
        b=RnZS4E78J66DTBX2QBp9SwowUihoXRR/89qCOt2KeWvyLEcGTX10Mi6edrImOLzK+j/TFO
        5NOSWvnrK7ZwKreedv0Yplf4i1Ps0ojeHti9JYJrMmDKYtSdw5svEvcUtFRxOdRVAohOgq
        bxaaMc+RqLl1O7Cprfhfc16hSESpAEg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-7iR0jhYKP0i-Mdlkf1kC-w-1; Tue, 09 May 2023 16:51:04 -0400
X-MC-Unique: 7iR0jhYKP0i-Mdlkf1kC-w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9662fbb79b3so367188066b.0
        for <cgroups@vger.kernel.org>; Tue, 09 May 2023 13:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683665463; x=1686257463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNiIZHyonT4Lc3v22Wd8EHVvgd0ES2GAsHIl3w6taTA=;
        b=A/I8vISmSrfqwrk3wFlZu/yFwQvQr7t2DgZrGn4aDB+R5sNO6TFCTlnHLWiemMmzYI
         hhY4gCtPfZiKlzfVCJBebCj9jaZd6PY52NsWPdQmUdQFupPl07kOq22/42laojWl6Rq5
         JfEs7GYqwxDgT0AcuFcBkXmr67RITU2xiPcKrOV5DNfcOP8Pj7g5A+2E0RaJfXgVdQRB
         TiytpWIhANPLz1Qgr+0rzZxZdyUmcLrD+r1ZmkcTWro7vbqinMwSv9+Me39zsBAiLvLA
         M6XQJ+trRgp1ap0h0ebDTbkL3NiYjOt48XLZEHkTBmUFlLrpa5hi1jrzpLQ+V/fP+Eh9
         /E3A==
X-Gm-Message-State: AC+VfDzYed8KKjecgwFRxBncfWHnI0i5erScshJt8rJYnsDlapmJFPa2
        M8jm2kyeny2fxujN5ToYrsC3leMwPB+tmHfJu6yMwHej2XYtpqnIMf4mqMApnKPq5T+bHSRNYMF
        b00Kvv+Qman3mXfyDyA==
X-Received: by 2002:a17:906:4fd1:b0:94f:21f3:b5f8 with SMTP id i17-20020a1709064fd100b0094f21f3b5f8mr12867377ejw.21.1683665463523;
        Tue, 09 May 2023 13:51:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64Z2n6Cyo1Ac1tIrysTfZgGptf8iyw8BdvNxTLiJKqxc+sT/Z3BRYol16b0K6FWwTa13f0sg==
X-Received: by 2002:a17:906:4fd1:b0:94f:21f3:b5f8 with SMTP id i17-20020a1709064fd100b0094f21f3b5f8mr12867347ejw.21.1683665463199;
        Tue, 09 May 2023 13:51:03 -0700 (PDT)
Received: from redhat.com ([82.180.150.238])
        by smtp.gmail.com with ESMTPSA id h9-20020a170906584900b0094e597f0e4dsm1735890ejs.121.2023.05.09.13.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:51:02 -0700 (PDT)
Date:   Tue, 9 May 2023 16:50:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        talumbau <talumbau@google.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] virtio-balloon: Add Working Set reporting
Message-ID: <20230509164528-mutt-send-email-mst@kernel.org>
References: <20230509185419.1088297-1-yuanchu@google.com>
 <20230509185419.1088297-3-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509185419.1088297-3-yuanchu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 10, 2023 at 02:54:19AM +0800, Yuanchu Xie wrote:
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..06d0683d8d8c 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h

Any changes to this have to be documented in the virtio spec
and be sent to virtio TC.

> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING 6 /* Working Set Size reporting */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -59,6 +60,8 @@ struct virtio_balloon_config {
>  	};
>  	/* Stores PAGE_POISON if page poisoning is in use */
>  	__le32 poison_val;
> +	/* Number of bins for Working Set report if in use. */
> +	__le32 ws_num_bins;

working_set_ pls. eschew abbreviation.
Really __le32? Is 4G bins reasonable? what if it's 0?

>  };
>  
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> @@ -116,4 +119,22 @@ struct virtio_balloon_stat {
>  	__virtio64 val;
>  } __attribute__((packed));
>  
> +enum virtio_balloon_ws_op {
> +	VIRTIO_BALLOON_WS_REQUEST = 1,
> +	VIRTIO_BALLOON_WS_CONFIG = 2,
> +};


what's this?

> +
> +struct virtio_balloon_ws {

document fields.

> +#define VIRTIO_BALLOON_WS_RECLAIMABLE 0
> +#define VIRTIO_BALLOON_WS_DISCARDABLE 1

what are these?

> +	/* TODO: Provide additional detail on memory, e.g. reclaimable. */

Well? If we don't now hypervisors will come to depend on
this being broken.

> +	__virtio16 tag;
> +	/* TODO: Support per-NUMA node reports. */

Same. This is ABI we can't merge with unaddressed TODO items.

> +	__virtio16 node_id;
> +	uint8_t reserved[4];
> +	__virtio64 idle_age_ms;
> +	/* Track separately for ANON_AND_FILE. */

What does this mean?

> +	__virtio64 memory_size_bytes[2];




> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */

Use LE for new features please.

-- 
MST

